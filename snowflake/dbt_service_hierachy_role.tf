## dbt_service hierarchy roles 
resource "snowflake_account_role" "dbt_service_access_role" {
  name    = "DBT_SERVICE_ACCESS_ROLE"
  comment = "Access role that permits read-only access to tables in the dbt_service_schema"
}

resource "snowflake_account_role" "dbt_service_functional_role" {
  name    = "DBT_SERVICE_FUNCTIONAL_ROLE"
  comment = "Functional role that permits read-only access to tables in the dbt_service_schema"
}

resource "snowflake_grant_account_role" "dbt_service_access_role_to_functional_role" {
  role_name        = snowflake_account_role.dbt_service_access_role.name
  parent_role_name = snowflake_account_role.dbt_service_functional_role.name
}

resource "snowflake_grant_account_role" "dbt_service_functional_role_to_useradmin" {
  role_name        = "SYSADMIN"
  parent_role_name = snowflake_account_role.dbt_service_functional_role.name
}