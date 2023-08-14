output "db_instance_endpoint" {
  value       = aws_db_instance.myinstance.endpoint
}
# to add more for dynamic use-cases