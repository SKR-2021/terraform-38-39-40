variable "component" {
    default = "catalogue" 
}

variable "instance_type" {
    default = "t3.micro"
}

variable "rule_priority" {
    default = 10
}

variable "domain_name" {
    default = "dso86s.xyz"
}

variable "components" {
    default = {
        catalogue = {
            rule_priority = 10
        }
        user = {
            rule_priority = 20
        }
        cart = {
            rule_priority = 30
        }
        shipping = {
            rule_priority = 40
        }
        payment = {
            rule_priority = 50
        }
        frontend = {
            rule_priority = 10
        }
    }
  
}