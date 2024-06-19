
output "pg_details" {
  description = "db and cluster pg name and arn"
  value = {
    instance_pg_name      = var.create_instance_pg ? aws_db_parameter_group.instance_pg[0].name : "n/a"
    instance_pg_arn       = var.create_instance_pg ? aws_db_parameter_group.instance_pg[0].arn : "n/a"
    cluster_pg_name = var.create_cluster_pg ? aws_rds_cluster_parameter_group.cluster_pg[0].name : "n/a"
    cluster_pg_arn  = var.create_cluster_pg ? aws_rds_cluster_parameter_group.cluster_pg[0].arn : "n/a"
  }
}
