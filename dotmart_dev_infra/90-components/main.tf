module "components" {
    source = "../../ terraform-dotmart-component"
    component = var.component
    rule_priority = var.rule_priority
}