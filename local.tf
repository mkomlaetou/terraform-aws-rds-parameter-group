
locals {
  cluster_pg_parameters = merge(var.cluster_pg_parameters, var.db_pg_parameters)
}
