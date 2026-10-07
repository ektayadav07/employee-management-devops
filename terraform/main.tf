terraform{
    required_providers{
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws"{
    region = var.aws_region
}
resource "aws_ecr_repository" "employee_app"{
    name = "employee-management-app" 
    tags = {
    Environment = "Dev" 
}      
}