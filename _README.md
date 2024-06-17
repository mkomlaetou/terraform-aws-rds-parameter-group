
# NOTE:

This module allows to create either a DB Instance or a DB Cluster Parameter Group or both.
This module was only tested on aurora-postgresql family parameter group.
 * by default, it creates both DB Instance and DB Cluster Parameter Groups
 * to only create a DB Instance Parameter Group, set the "create_cluster_pg" variable to false
 * to only create a DB Cluster Parameter Group, set the "create_db_pg" variable to false
 * the end result of a Cluster Parameter Group is the merger of db_pg_parameters and cluster_pg_parameters values


#---------------------------------------------------------------------
# SAMPLE CODE
#---------------------------------------------------------------------
```
#################################
# CRM RDS Parameter Group
#################################
module "crm_db_pg_aurora-postgresql-15" {
  source                = "../../../modules/rds_parameter_group"
  
  pg_info               = var.crm_db_pg_info
  db_pg_parameters      = var.crm_db_pg_parameters
  cluster_pg_parameters = var.crm_cluster_pg_parameters
}


// PG VARIABLES

variable "crm_db_pg_info" {
  description = "parameter group name & family"
  default = {
    name        = "crm-db-aurora-postgresql15-latest"
    family      = "aurora-postgresql15"
    description = "crm-db-aurora-postgresql15-latest"
  }
}

//
variable "db_pg_parameters" {
  description = "parameters for db instance"
  default = {
    db_parameter1 = {
      name         = "max_connections"
      value        = "10000"
      apply_method = "pending-reboot"
    }
    db_parameter2 = {
      name         = "tcp_keepalives_count"
      value        = "2"
      apply_method = "immediate"
    }
    db_parameter3 = {
      name         = "tcp_keepalives_idle"
      value        = "10"
      apply_method = "immediate"
    }
    db_parameter4 = {
      name         = "tcp_keepalives_interval"
      value        = "10"
      apply_method = "immediate"
    }
  }
}

variable "cluster_pg_parameters" {
  description = "parameters for db cluster"
  default = {
    cl_parameter1 = {
      name         = "password_encryption"
      value        = "md5"
      apply_method = "immediate"
    }
    # cl_parameter2 = {
    #   name         = "apg_write_forward.idle_in_transaction_session_timeout"
    #   value        = "0"
    #   apply_method = "immediate"
    # }
  }
}


// PG OUTPUT
output "crm_db" {
  description = "value of crmdb"
  value = module.crm_db_pg_aurora-postgresql-15.pg_details
}


```
