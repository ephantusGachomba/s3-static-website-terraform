variable "bucket_name" {
  description = "The name of the s3 bucket to store html"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}