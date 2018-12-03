provider "aws" {
	access_key = "access_key"
	secret_key = "sec"
	region = "ap-southeast-2"
}
# terraform state file setup
# create an S3 bucket to store the state file in
resource "aws_s3_bucket" "kavita-terraform-state-storage-s3" {
    bucket = "kavita-terraform-state-storage-s3"
	acl = "public"
 
    versioning {
      enabled = true
    }
 
    lifecycle {
      prevent_destroy = true
    }
 
    tags {
      Name = "S3 Remote Terraform State Store"
    }

	Static      
}