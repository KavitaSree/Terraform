terraform {
 backend “s3” {
 encrypt = true
 bucket = "kavita-terraform-state-storage-s3"
 region = us-west-2
 key = "${path_relative_to_include()}/terraform.tfstate"
 }
}