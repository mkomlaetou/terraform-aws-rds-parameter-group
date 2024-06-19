
// default tag
locals {
  default_tags = {
    IACTool = "terraform"
  }

  tags = merge(local.default_tags, var.additional_tags)
}
