provider "aws" {
	access_key = "AKIAJVV6S6F4IJWYX3GQ"
	secret_key = "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"
	region = "ap-southeast-2"
}
# terraform state file setup
# create an S3 bucket to store the state file in
resource "aws_s3_bucket" "kavita-terraform-blah-storage-s3" {
    bucket = "kavita-terraform-blah-storage-s3"
 
    versioning {
      enabled = true
    }
 
    lifecycle {
      prevent_destroy = true
    }
 
    tags {
      Name = "Kavits S3 Remote Terraform State Store"
    }
      
}