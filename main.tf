
// CREATE A CLUSTER PARAMETER GROUP
resource "aws_rds_cluster_parameter_group" "cluster_pg" {
  count       = var.create_cluster_pg ? 1 : 0
  name        = var.pg_info["name"]
  family      = var.pg_info["family"]
  description = var.pg_info["description"] == "" ? "${var.pg_info["name"]} Cluster PG" : var.pg_info["description"]

  dynamic "parameter" {
    for_each = local.cluster_pg_parameters
    content {
      name         = parameter.value["name"]
      value        = parameter.value["value"]
      apply_method = parameter.value["apply_method"]
    }
  }
}


// CREATE A DB INSTANCE  PARAMETER GROUP
resource "aws_db_parameter_group" "db_pg" {
  count       = var.create_db_pg ? 1 : 0
  name        = var.pg_info["name"]
  family      = var.pg_info["family"]
  description = var.pg_info["description"] == "" ? "${var.pg_info["name"]} Db PG" : var.pg_info["description"]

  dynamic "parameter" {
    for_each = var.db_pg_parameters
    content {
      name         = parameter.value["name"]
      value        = parameter.value["value"]
      apply_method = parameter.value["apply_method"]
    }
  }
}




