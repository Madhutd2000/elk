module "security_group" {
  count = length(var.security_groups)
  source = "git::https://github.worldpay.com/Docet-USA/security_group.git//security_group" # path to the module which has terraform script to create sg
  #source = "git::git@github.worldpay.com:Docet-USA/security_group.git//security_group"
  vpc_id = var.vpc_id
  description = var.security_groups[count.index].description
  name = var.sg_name
  ingress_rules = var.security_groups[count.index].ingress_rules
  egress_rules = var.security_groups[count.index].egress_rules
}
