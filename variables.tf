variable "bucket_name" {
  description = "Name of S3 bucket to create"
  type        = "string"
}

variable "noncurrent_lifecycle_enabled" {
    description = "Old versions lifecycle on/off"
    default = "true"
}

variable "noncurrent_lifecycle_days_infrequent" {
    description = "Number of days before noncurrent versions are moved to infrequent access"
    default = 30
}

variable "noncurrent_lifecycle_days_glacier" {
    description = "Number of days before noncurrent versions are moved to glacier"
    default = 90
}

variable "noncurrent_lifecycle_days_expiration" {
    description = "Number of days before noncurrent versions are deleted"
    default = 180
}

variable "tags" {
    type = "map"
    default = {
        ManagedBy = "terraform"
    }
}
