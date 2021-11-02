provider "aws" {
  region  = "us-east-2"
  profile = "default"
}

resource "aws_s3_bucket" "b" {
  bucket = "flaskappterraform"
  acl    = "private"

  versioning {
    enabled = true
  }
}
