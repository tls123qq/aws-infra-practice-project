resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Allow HTTP from internet to ALB"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "aws_infra_practice_alb_sg"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow HTTP from ALB to EC2"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "aws_infra_practice_ec2_sg"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow PostgreSQL from EC2 to RDS"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "aws_infra_practice_rds_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_sg_in_rule" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "ec2_sg_in_rule" {
  security_group_id            = aws_security_group.ec2_sg.id
  referenced_security_group_id = aws_security_group.alb_sg.id
  from_port                    = 4000
  ip_protocol                  = "tcp"
  to_port                      = 4000
}

resource "aws_vpc_security_group_ingress_rule" "rds_sg_in_rule" {
  security_group_id            = aws_security_group.rds_sg.id
  referenced_security_group_id = aws_security_group.ec2_sg.id
  from_port                    = 5432
  ip_protocol                  = "tcp"
  to_port                      = 5432
}

resource "aws_vpc_security_group_egress_rule" "alb_sg_out_rule" {
  security_group_id            = aws_security_group.alb_sg.id
  referenced_security_group_id = aws_security_group.ec2_sg.id
  from_port                    = 4000
  ip_protocol                  = "tcp"
  to_port                      = 4000
}

resource "aws_vpc_security_group_egress_rule" "ec2_sg_out_to_rds_rule" {
  security_group_id            = aws_security_group.ec2_sg.id
  referenced_security_group_id = aws_security_group.rds_sg.id
  from_port                    = 5432
  ip_protocol                  = "tcp"
  to_port                      = 5432
}

resource "aws_vpc_security_group_egress_rule" "ec2_sg_out_to_itn_rule" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}