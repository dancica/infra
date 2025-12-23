terraform {
  backend "s3" {
    region  = "us-east-1"

    bucket         = "beni-juce-tf-state"
    key            = "infra/environments/prod/terraform.tfstate"
    dynamodb_table = "terraform-state"
    encrypt        = true
  }
}
