resource "aws_ecr_repository" "ecr" {
  name                 = "aws-infra-practice-app"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true

  tags = {
    Name = "aws_infra_practice_ecr"
  }
}