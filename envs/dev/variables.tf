variable "bucket_name" {
  description = "The name of the S3 bucket for the dev environment"
  type        = string
  #default     = "dev_static_website_bucket_efantus_new"
}

variable "tags" {
  description = "Tags for resources in dev environment"
  type        = map(string)
  default = {
    "Environment" = "dev"
  }
}
