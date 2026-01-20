resource "aws_s3_bucket" "terr-statefile-bucket" {
  bucket = "terr-statefile-bucket"
  region = "eu-north-1"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.terr-statefile-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "lock_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "lock_table"
    Environment = "prod"
  }
}

provider "aws" {
  region = "eu-north-1"
}
