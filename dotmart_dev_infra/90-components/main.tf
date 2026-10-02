module "components" {
    source = "../../../terraform-dotmart-component"
    component = var.component
    rule_priority = var.rule_priority
    instance_type = var.instance_type
    domain_name = var.domain_name
}