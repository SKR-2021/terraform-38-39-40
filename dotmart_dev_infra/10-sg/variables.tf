variable "project_name" {
    default = "dotmart"
}

variable "environment" {
    default = "dev"
}

variable "sg_names" {
    default = [
        # Data Bases
        "mongodb", "redis", "mysql", "rabbitmq",
        # Backend 
        "catalogue", "user", "cart", "shipping", "payment",
        # Frontend 
        "fronend",       
        # Bastion
        "bastion"
    ]
}