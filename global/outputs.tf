output "aws_iam_openid_connect_provider" {
  value = aws_iam_openid_connect_provider.github.arn
}

output "terraform_state_bucket" {
  value = aws_s3_bucket.terraform_state.arn
}

output "dynamodb_table" {
  value = aws_dynamodb_table.terraform_state.arn
}