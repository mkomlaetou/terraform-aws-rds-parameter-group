
// default tag
locals {
  default_tags = {
    IACTool = "terraform"
  }

  tags = merge(local.default_tags, var.additional_tags)
}

# 
# locals {
#   cluster_pg_parameters = merge(var.cluster_pg_parameters, var.instance_pg_parameters)
# }
