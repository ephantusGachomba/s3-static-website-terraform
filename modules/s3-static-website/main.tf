#create the s3 bucket
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
  tags   = var.tags
}

#Configuration of the S3 bucket website.
resource "aws_s3_bucket_website_configuration" "website_static" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }
}

#bucket policy ensures that all objects, regardless of how they are uploaded or by whom, will be accessible publicly.
#using bucket policies over ACLs provide better visibility and manageability
#bucket policy ensures consistent, secure, and more flexible access control
resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = data.aws_iam_policy_document.website_policy.json
}

data "aws_iam_policy_document" "website_policy" {
  statement {
    actions = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = ["${aws_s3_bucket.website_bucket.arn}/*"]
    effect    = "Allow"
  }
}

resource "aws_s3_bucket_public_access_block" "website_bucket_block" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

locals {
  s3_origin_id = "${var.bucket_name}-origin"
  s3_domain_name = "${var.bucket_name}.s3-website-${var.region}.amazonaws.com"
}


resource "aws_cloudfront_distribution" "cdn" {
    origin {
    domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name 
    origin_id   = var.original_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.original_id

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  depends_on = [aws_s3_bucket.website_bucket]
}