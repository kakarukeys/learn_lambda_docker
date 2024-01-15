# write a terraform script to create an ECR repository with the following requirements
# 1. scan image on push
# 2. tag is immutable
# 3. a lifecycle policy is attached to clean up any images older than 1 year old
#
# the policy should be inside aws_ecr_lifecycle_policy resource

resource "aws_ecr_repository" "my_ecr_repository" {
  name = "my-ecr-repository"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "IMMUTABLE"
  force_delete = true
}

resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
 repository = aws_ecr_repository.my_ecr_repository.name

 policy = <<EOF
{
 "rules": [
   {
     "rulePriority": 1,
     "description": "Expire images older than 1 year",
     "selection": {
       "tagStatus": "any",
       "countType": "sinceImagePushed",
       "countUnit": "days",
       "countNumber": 365
     },
     "action": {
       "type": "expire"
     }
   }
 ]
}
EOF
}
