
# USAGE:

This module allows to create either a DB Instance or a DB Cluster Parameter Group or both.
This module was only tested on aurora-postgresql family parameter group.
 * by default, it creates both DB Instance and DB Cluster Parameter Groups.
 * to only create a DB Instance Parameter Group, set the "create_cluster_pg" variable to false.
 * to only create a DB Cluster Parameter Group, set the "create_db_pg" variable to false.
 * if no value is provided for pg_info["description"], the Parameter Group description will be generated automatically.
 * parameter "apply_method" default value is "pending-reboot". 



## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_parameter_group.instance_pg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_rds_cluster_parameter_group.cluster_pg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pg_info"></a> [pg\_info](#input\_pg\_info) | paramager group name and family | <pre>object({<br>    name        = string<br>    family      = string<br>    description = optional(string, "")<br>  })</pre> | n/a | yes |
| <a name="input_create_cluster_pg"></a> [create\_cluster\_pg](#input\_create\_cluster\_pg) | requred when creating cluster parameter group | `bool` | `true` | no |
| <a name="input_create_instance_pg"></a> [create\_instance\_pg](#input\_create\_instance\_pg) | required when creating db parameter group | `bool` | `true` | no |
| <a name="input_instance_pg_parameters"></a> [instance\_pg\_parameters](#input\_instance\_pg\_parameters) | parameters of db parameter group | <pre>map(object({<br>    name         = optional(string, "")<br>    value        = optional(string, "")<br>    apply_method = optional(string, "pending-reboot")<br>  }))</pre> | `{}` | no |
| <a name="input_cluster_pg_parameters"></a> [cluster\_pg\_parameters](#input\_cluster\_pg\_parameters) | parameters of cluster parameter group | <pre>map(object({<br>    name         = optional(string, "")<br>    value        = optional(string, "")<br>    apply_method = optional(string, "pending-reboot")<br>  }))</pre> | `{}` | no |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pg_details"></a> [pg\_details](#output\_pg\_details) | db and cluster pg name and arn |


#---------------------------------------------------------------------
# SAMPLE CODE
#---------------------------------------------------------------------
```
#################################
# xyz RDS Parameter Group
#################################
module "xyz_db_pg_aurora-postgresql-15" {
  source  = "mkomlaetou/rds-parameter-group/aws"
  version = "1.0.1"
  
  pg_info               = var.xyz_pg_info
  db_pg_parameters      = var.xyz_db_pg_parameters
  cluster_pg_parameters = var.xyz_cluster_pg_parameters
  additional_tags       = var.additional_tags
}


// PG VARIABLES

variable "xyz_pg_info" {
  description = "parameter group name & family"
  default = {
    name        = "xyz-db-aurora-postgresql15-latest"
    family      = "aurora-postgresql15"
    description = "xyz-db-aurora-postgresql15-latest"
  }
}

//
variable "xyz_db_pg_parameters" {
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

variable "xyz_cluster_pg_parameters" {
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


// Additional tags to be added to all resources
variable "additional_tags" {
  type = map(string)
  default = {
    Environment = "PROD"
  }
}

// PG OUTPUT
output "xyz_db" {
  description = "value of xyzdb"
  value = module.xyz_db_pg_aurora-postgresql-15.pg_details
}


```
