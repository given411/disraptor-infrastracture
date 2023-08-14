variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
}

variable "lock_table_name" {
  description = "Name of the DynamoDB table for Terraform locking"
}
