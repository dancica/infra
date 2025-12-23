data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    profile = "global"
    region  = "us-east-1"

    bucket = "beni-juce-tf-state"
    key    = "infra/global/terraform.tfstate"
  }
}

data "aws_iam_policy_document" "oidc" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [data.terraform_remote_state.global.outputs.aws_iam_openid_connect_provider]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.repo_name}:*"]
    }
  }
}

data "aws_iam_policy_document" "permissions" {
  statement {
    sid       = "AllowEnvScopedActions"
    effect    = "Allow"
    actions   = ["ec2:*", "s3:*"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowBucketListing"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [
      data.terraform_remote_state.global.outputs.terraform_state_bucket
    ]
  }

  statement {
    sid    = "AllowStateFileAccess"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      format("%s/infra/environments/%s/terraform.tfstate", data.terraform_remote_state.global.outputs.terraform_state_bucket, var.environment)
    ]
  }

  statement {
    sid    = "AllowDynamoDBLocking"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [
      data.terraform_remote_state.global.outputs.dynamodb_table
    ]
  }
}

resource "aws_iam_role" "github_oidc" {
  name               = "${var.environment}-actions-role"
  assume_role_policy = data.aws_iam_policy_document.oidc.json
}

resource "aws_iam_role_policy" "github_permissions" {
  name   = "EnvPermissions"
  role   = aws_iam_role.github_oidc.id
  policy = data.aws_iam_policy_document.permissions.json
}
