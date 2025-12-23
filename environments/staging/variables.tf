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


# INSTANCE

variable "instance_type" {
  description = "The size of the instance"
  type        = string
  default     = "t3.micro"
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "repo_name" {
  description = "Repo name"
  type        = string
}