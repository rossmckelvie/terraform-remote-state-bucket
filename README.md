# terraform-remote-state-bucket
Terraform module to create an encrypted remote state bucket. Versioning always
enabled; lifecycle rules are enabled unless overridden.

Resolves security issues from [Scout2] that arise when creating a vanilla bucket,
except MFA required for version deletion, so that terraform can be automated.

## Usage
```hcl
module "remote-state-bucket" {
  source = "github.com/rossmckelvie/terraform-remote-state-bucket"

  bucket_name = "example-bucket"

  noncurrent_lifecycle_enabled = true
  noncurrent_lifecycle_days_infrequent = 3
  noncurrent_lifecycle_days_glacier = 30
  noncurrent_lifecycle_days_expiration = 180

  tags = {
      ManagedBy = "terraform"
      RemoteStateProject = "example-project"
  }
}
```

## Variables
| Variable                               | Required | Default  | Description                                                              |
|----------------------------------------|----------|----------|--------------------------------------------------------------------------|
| `bucket_name`                          | Yes      |          | Name of bucket to create |
| `noncurrent_lifecycle_enabled`         | No       | `true`   | When enabled, old versions are moved to IA -> Glacier -> Deleted |
| `noncurrent_lifecycle_days_infrequent` | No       | `30`     | Number of days before noncurrent versions are moved to infrequent access |
| `noncurrent_lifecycle_days_glacier`    | No       | `90`     | Number of days before noncurrent versions are moved to glacier |
| `noncurrent_lifecycle_days_expiration` | No       | `365`    | Number of days before noncurrent versions are deleted |
| `tags`                                 | No       | `ManagedBy = "terraform"` | Tags to apply to bucket |

## Outputs
| Output        | Description                |
|---------------|----------------------------|
| `bucket_name` | Name of the bucket created |


[Scout2]: https://github.com/nccgroup/ScoutSuite
