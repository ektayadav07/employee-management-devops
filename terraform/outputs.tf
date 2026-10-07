output "ecr_repository_uri" {
    description = "URI of the Employee Management ECR repository"
    value = aws_ecr_repository.employee_app.repository_url
}