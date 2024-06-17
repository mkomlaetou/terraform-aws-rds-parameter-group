
output "pg_details" {
  description = "db and cluster pg name and arn"
  value = {
    # db_pg_name      = aws_db_parameter_group.db_pg.name
    # db_pg_arn       = aws_db_parameter_group.db_pg.arn
    # cluster_pg_name = aws_rds_cluster_parameter_group.cluster_pg[0].name
    # cluster_pg_arn  = aws_rds_cluster_parameter_group.cluster_pg[0].arn
    db_pg_name      = var.create_db_pg ? aws_db_parameter_group.db_pg[0].name : "n/a"
    db_pg_arn       = var.create_db_pg ? aws_db_parameter_group.db_pg[0].arn : "n/a"
    cluster_pg_name = var.create_cluster_pg ? aws_rds_cluster_parameter_group.cluster_pg[0].name : "n/a"
    cluster_pg_arn  = var.create_cluster_pg ? aws_rds_cluster_parameter_group.cluster_pg[0].arn : "n/a"
  }
}
