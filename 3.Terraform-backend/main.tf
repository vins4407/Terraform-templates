provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "vins" {
  instance_type = "t2.micro"
  ami = "ami-04b70fa74e45c3917"
}
resource "aws_instance" "vins-4407" {
  instance_type = "t2.micro"
  ami = "ami-04b70fa74e45c3917"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "vins-s3"
}

resource "aws_dynamodb_table" "example" {
  name             = "example"
  hash_key         = "TestTableHashKey"
  billing_mode     = "PAY_PER_REQUEST"

  attribute {
    name = "TestTableHashKey"
    type = "S"
  }


}