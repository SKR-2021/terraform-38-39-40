locals {
    comman_tags = {
        Project = var.project_name
        Environment = var.environment
        Terraform = true

    }

    comman_name_suffix = "${var.project_name}-${var.environment}" # dotmart-dev

    
}