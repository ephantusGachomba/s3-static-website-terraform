variable "region" {
  description = "Region"
  type = string
  default = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "original_id" {
  description = "The original ID for CloudFront"
  type        = string
  default     = "S3-Origin"
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  default     = {}
}