resource "aws_s3_bucket" "insecure-bucket" {
  bucket = "insecure-bucket"
  acl    = "private"  # Set ACL to private
  versioning {
    enabled = true
  }
  logging {
    target_bucket = aws_s3_bucket.insecure-bucket.bucket
    target_prefix = "s3-logs/"
  }
  force_destroy = true  # Enable force_destroy to allow deletion of non-empty bucket
}

resource "aws_s3_bucket_public_access_block" "insecure-bucket" {
  bucket = aws_s3_bucket.insecure-bucket.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 20
  encrypted         = true
  tags = {
    Name = "insecure"
  }
}
