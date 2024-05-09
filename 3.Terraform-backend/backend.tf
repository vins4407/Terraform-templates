terraform {
  backend "s3" {
    bucket = "vins-s3"
    region = "us-east-1"
    key = "vins/terraform.tfstate"
    dynamodb_table = ""
  }
}
