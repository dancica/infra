variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "versioning_enabled" {
  description = "Versioning"
  type        = string
  default     = "Enabled"
}
