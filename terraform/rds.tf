resource "aws_db_subnet_group" "rds_subnet" {
  name       = "rds_subnets"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  tags = {
    Name = "aws_infra_practice_rds_subnet"
  }
}

resource "aws_db_instance" "rds_instance" {
  identifier             = "aws-infra-practice-rds"
  allocated_storage      = 20
  db_name                = "realworld"
  engine                 = "postgres"
  engine_version         = "16"
  instance_class         = "db.t3.micro"
  username               = "postgres"
  password               = var.db_password
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible    = false
  multi_az               = false

  tags = {
    Name = "aws_infra_practice_rds_instance"
  }
}