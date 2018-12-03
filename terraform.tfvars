terragrunt = {
  remote_state {
    backend = "s3"
    config {
      bucket         = "kavita-terraform-state-storage-s3"
      key            = "${path_relative_to_include()}/terraform.tfstate"
      region         = "ap-southeast-2"
      encrypt        = true
    }
  }
}