provider "aws" {
  region = "us-east-1"
}

module "s3_static_website" {
  source      = "../../modules/s3-static-website"
  bucket_name = var.bucket_name
  tags        = var.tags
}

