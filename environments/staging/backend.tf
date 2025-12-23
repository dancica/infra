terraform {
  backend "s3" {
    region  = "us-east-1"

    bucket         = "beni-juce-tf-state"
    key            = "infra/environments/staging/terraform.tfstate"
    dynamodb_table = "terraform-state"
    encrypt        = true
  }
}
