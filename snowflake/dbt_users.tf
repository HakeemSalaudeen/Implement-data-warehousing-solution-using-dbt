resource "snowflake_user" "DBT_ECS_USER" {
  name       = "DBT_ECS_USER"
  login_name = "DBT_USER"
  first_name = "DBT"
  # middle_name  = var.middle_name
  last_name    = "USER"
  comment      = "user for DBT in ecs task definition"
  password     = var.abdulhakeem_password
  disabled     = "false"
  display_name = "DBT_ECS_USER"
  # email        = "abdulhakeem.salaudeen@company.com"

  default_warehouse = snowflake_warehouse.dbt-compute-warehouse.fully_qualified_name
  default_role      = snowflake_account_role.dbt_service_functional_role.name
  default_namespace = snowflake_schema.bronze_schema.fully_qualified_name

  must_change_password = "false"
  disable_mfa          = "false"
}