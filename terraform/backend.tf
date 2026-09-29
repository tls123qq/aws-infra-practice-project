terraform {
  backend "s3" {
    bucket         = "s3-tfstate-shokun-practice"
    key            = "terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-locks"
  }
}