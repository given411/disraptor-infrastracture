output "s3_bucket_name" {
  value = aws_s3_bucket.terrafom_state.id
}

output "lock_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}
