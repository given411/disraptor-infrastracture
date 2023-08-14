variable "db_instance_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "db_name" {
  description = "Name of the initial database"
  type        = string
}

# to add more for dynamic use-cases
