# INSTANCE

variable "instance_type" {
  description = "The size of the instance"
  type        = string
  default     = "t3.micro"
}

variable "instance_tags" {
  type        = map(string)
  description = "A map of tags to assign to the instance"
  default     = {} # Optional: module works even if staging doesn't provide tags
}