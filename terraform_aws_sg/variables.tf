variable "project_name" {
    type = string
    default = ""
}

variable "environment" {
    type = string
    default = ""
}

variable "sg_name" {
    type = string
    default = ""
}

variable "sg_description" {
    type = string
    default = ""
}

variable "vpc_id" {
    type = string
    default = ""
}

variable "sg_tags" {
    type = map
    default = ""
}