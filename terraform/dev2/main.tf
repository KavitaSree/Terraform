provider "aws" {
	access_key = "AKIAJVV6S6F4IJWYX3GQ"
	secret_key = "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"
	region = "ap-southeast-2"
}

resource "aws_s3_bucket" "logs" {
  bucket = "${var.site_name}-site-logs"
  acl = "log-delivery-write"
}

data "template_file" "bucket_policy" {
  template = "${file("bucket_policy.json")}"
  vars {
    origin_access_identity_arn = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    bucket = "${aws_s3_bucket.www_site.arn}"
  }
}

resource "aws_s3_bucket" "www_site" {
  bucket = "www.${var.site_name}"
  logging {
    target_bucket = "${aws_s3_bucket.logs.bucket}"
    target_prefix = "www.${var.site_name}/"
  }
  website {
    index_document = "index.html"
  }
}

resource "aws_acm_certificate" "cert" {
  domain = "www.example.com"
}

resource "aws_route53_record" "www_site" {
  zone_id = "${data.aws_route53_zone.site.zone_id}"
  name = "www.${var.site_name}"
  type = "A"
  alias {
    name = "${aws_cloudfront_distribution.website_cdn.domain_name}"
    zone_id  = "${aws_cloudfront_distribution.website_cdn.hosted_zone_id}"
    evaluate_target_health = false
  }
}