resource "aws_s3_bucket" "terraform_state_storage_s3" {
  bucket = "${var.bucket_name}"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  lifecycle_rule {
    enabled = "${var.noncurrent_lifecycle_enabled}"

    noncurrent_version_transition {
      days          = "${var.noncurrent_lifecycle_days_infrequent}"
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = "${var.noncurrent_lifecycle_days_glacier}"
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = "${var.noncurrent_lifecycle_days_expiration}"
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.terraform_remote_state_encryption_key.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = "${var.tags}"
}

