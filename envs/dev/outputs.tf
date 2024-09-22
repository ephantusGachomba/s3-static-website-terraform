# Output the S3 bucket name
output "s3_bucket_name" {
  value = var.bucket_name
  description = "The name of the S3 bucket"
}

# Output the CloudFront distribution domain name
output "cloudfront_domain_name" {
  value = module.s3_static_website.cloudfront_domain_name
  description = "The domain name of the CloudFront distribution"
}

# Output the CloudFront distribution ID
output "cloudfront_distribution_id" {
  value = module.s3_static_website.cloudfront_distribution_id
  description = "The ID of the CloudFront distribution"
}
