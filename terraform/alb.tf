resource "aws_lb" "alb" {
  name               = "aws-infra-practice-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  tags = {
    Name = "aws_infra_practice_alb"
  }
}

resource "aws_lb_target_group" "alb_target_group" {
  name                 = "alb-target-group"
  port                 = 4000
  protocol             = "HTTP"
  vpc_id               = aws_vpc.main.id
  target_type          = "instance"
  deregistration_delay = 30

  health_check {
    path    = "/health"
    matcher = "200"
  }

  tags = {
    Name = "aws_infra_practice_target_group"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}