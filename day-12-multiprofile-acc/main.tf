provider "aws" {
  region  = "ap-south-1"
  profile = "megha"
}

resource "aws_s3_bucket" "dev" {
  bucket="ravsanmeg1234"
}