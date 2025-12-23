# AWS

variable "aws_profile" {
  type        = string
  description = "AWS profile"
  default     = ""
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "dynamodb_name" {
  description = "DynamoDB name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}