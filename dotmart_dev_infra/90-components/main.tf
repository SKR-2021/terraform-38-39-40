# module "components" {
#     source = "../../../terraform-dotmart-component"
#     component = var.component
#     rule_priority = var.rule_priority
#     instance_type = var.instance_type
#     domain_name = var.domain_name
# }

module "components" {
    for_each = var.components
    source = "git::https://github.com/SKR-2021/terraform-dotmart-component.git?ref=main"
    component = each.key
    rule_priority = each.value.rule_priority
    instance_type = var.instance_type
    
}