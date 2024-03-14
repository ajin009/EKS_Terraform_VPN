terraform {
  backend "s3" {
        bucket = "visal-bucket32"
        key     = "myproject01/terraform.tfstate"
        region = "us-east-1"
  }
}