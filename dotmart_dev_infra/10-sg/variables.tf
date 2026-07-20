variable "project_name" {
    default = "dotmart"
}

variable "environment" {
    default = "dev"
}

variable "sg_names" {
    default = ["mongodb", "redis", "mysql", "rabbitmq"]
}