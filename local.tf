
locals {
  cluster_pg_parameters = merge(var.cluster_pg_parameters, var.instance_pg_parameters)
}
