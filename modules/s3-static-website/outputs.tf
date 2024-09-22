# Output the S3 bucket name
output "s3_bucket_name" {
  value = aws_s3_bucket.website_bucket.bucket
  description = "The name of the S3 bucket"
}

# Output the CloudFront distribution domain name
output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
  description = "The domain name of the CloudFront distribution"
}

# Output the CloudFront distribution ID
output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.cdn.id
  description = "The ID of the CloudFront distribution"
}