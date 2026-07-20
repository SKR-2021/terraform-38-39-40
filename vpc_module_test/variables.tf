variable "vpc_cidr" {
  default = "10.30.0.0/16"
}

variable "project_name" {
  default = "dotmart"
}

variable "environment" {
  default = "dev"
}

variable "vpc_tags" {
  default = {
    Purpose    = "vpc_module_test"
    DontDelete = "true"
  }
}

variable "public_subnet_cidrs" {
    default = ["10.30.1.0/24", "10.30.2.0/24"]
}

variable "private_subnet_cidrs" {
    default = ["10.30.11.0/24", "10.30.12.0/24"]
}

variable "database_subnet_cidrs" {
    default = ["10.30.21.0/24", "10.30.22.0/24"]
}