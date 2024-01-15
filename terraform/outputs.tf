output "region" {
  description = "AWS region"
  value       = var.region
}

output "repository_url" {
  description = "AWS region"
  value       = aws_ecr_repository.my_ecr_repository.repository_url
}
