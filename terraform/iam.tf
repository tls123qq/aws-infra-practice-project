resource "aws_iam_role" "pull_ecr" {
  name = "pull_ecr"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "pull_ecr_policy" {
  role       = aws_iam_role.pull_ecr.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "pull_ecr_inst_prof" {
  name = "pull_ecr_inst_prof"
  role = aws_iam_role.pull_ecr.id
}

resource "aws_iam_role_policy_attachment" "ssm_ec2" {
  role = aws_iam_role.pull_ecr.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}