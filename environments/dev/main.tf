module "ec2_instance" {
  source = "../../modules/ec2"

  instance_type = var.instance_type

  instance_tags = {
    Name        = format("%s-app1", var.environment)
    Environment = var.environment
  }
}

module "logs_bucket" {
  source      = "../../modules/s3"
  bucket_name = format("%s-beni-juce", var.environment)
  environment = var.environment
}

module "github_role" {
  source      = "../../modules/github_oidc"
  environment = var.environment
  repo_name   = var.repo_name
}