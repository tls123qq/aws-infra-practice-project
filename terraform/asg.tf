resource "aws_autoscaling_group" "asg_ec2" {
  name                      = "asg_ec2"
  min_size                  = 1
  max_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  vpc_zone_identifier       = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  target_group_arns         = [aws_lb_target_group.alb_target_group.arn]
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
  depends_on = [aws_nat_gateway.NATGW_1, aws_route_table_association.private_1_sub_route, aws_route_table_association.private_2_sub_route]
}