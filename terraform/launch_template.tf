data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_launch_template" "launch_template" {
  name          = "launch_template"
  image_id      = data.aws_ssm_parameter.ami.value
  instance_type = "t3.micro"
  iam_instance_profile {
    name = aws_iam_instance_profile.pull_ecr_inst_prof.name
  }
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data              = filebase64("${path.module}/user_data.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "aws_infra_practice_ec2"
    }
  }
}