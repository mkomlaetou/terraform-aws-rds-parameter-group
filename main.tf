###############################
# CREATE DB CLUSTER AND INSTANCE PARAMETER GROUP
##############################

// create a cluster parameter group
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


// create an instance parameter group
resource "aws_db_parameter_group" "instance_pg" {
  count       = var.create_instance_pg ? 1 : 0
  name        = var.pg_info["name"]
  family      = var.pg_info["family"]
  description = var.pg_info["description"] == "" ? "${var.pg_info["name"]} Instance PG" : var.pg_info["description"]

  dynamic "parameter" {
    for_each = var.instance_pg_parameters
    content {
      name         = parameter.value["name"]
      value        = parameter.value["value"]
      apply_method = parameter.value["apply_method"]
    }
  }
}




