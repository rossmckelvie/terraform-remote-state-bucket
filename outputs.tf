output "bucket_name" {
  value = "${aws_s3_bucket.terraform_state_storage_s3.bucket}"
}
