
resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 20
  storage_type        = "gp2"
  engine              = "mysql"
  engine_version      = "5.7"
  instance_class      = "db.t2.micro"
  name                = var.db_instance_identifier
  username            = "admin"
  password            = "your_password_here"
  parameter_group_name = "default.mysql5.7"

  

  tags = {
    Name = "lms-test-rds"
  }
}
# to add more for dynamic use-cases
