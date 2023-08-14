
resource "aws_db_instance" "rds_instance" {
 engine               = "mysql"
  identifier           = "myrdsinstance"
  allocated_storage    =  20
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "myrdsuser"
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  //vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  skip_final_snapshot  = true
  publicly_accessible =  true
  tags = {
    Name = "lms-test-rds"
  }
}
# to add more for dynamic use-cases
