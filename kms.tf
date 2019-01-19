resource "aws_kms_key" "terraform_remote_state_encryption_key" {
  deletion_window_in_days = 10
  tags                    = "${var.tags}"
}
