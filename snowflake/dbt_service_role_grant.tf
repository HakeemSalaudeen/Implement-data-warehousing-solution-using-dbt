resource "snowflake_grant_privileges_to_account_role" "dbt_service_deployment_role_schema_privileges" {
  account_role_name = snowflake_account_role.dbt_service_access_role.name
  privileges = [
    "USAGE",
    "CREATE TABLE",
    "CREATE VIEW",
    "CREATE STAGE",
    "CREATE FUNCTION",
    "CREATE FILE FORMAT",
    "MODIFY"
  ]

  on_schema {
    all_schemas_in_database = snowflake_database.prod_db.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_service_deployment_role_future_schema_privileges" {
  account_role_name = snowflake_account_role.dbt_service_access_role.name
  privileges = [
    "USAGE",
    "CREATE TABLE",
    "CREATE VIEW",
    "CREATE STAGE",
    "CREATE FUNCTION",
    "CREATE FILE FORMAT",
    "MODIFY"
  ]

  on_schema {
    future_schemas_in_database = snowflake_database.prod_db.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_service_access_role_warehouse_usage" {
  account_role_name = snowflake_account_role.dbt_service_access_role.name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.dbt-compute-warehouse.name
  }
}

# Grant the USAGE privilege on the prod_db database to the access role
resource "snowflake_grant_privileges_to_account_role" "dbt_service_access_role_prod_db_usage" {
  account_role_name = snowflake_account_role.dbt_service_access_role.name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.prod_db.name
  }
}

# Grant USAGE on all schemas in the prod_db database to the access role
resource "snowflake_grant_privileges_to_account_role" "dbt_service_access_role_schema_usage" {
  account_role_name = snowflake_account_role.dbt_service_access_role.name
  privileges        = ["USAGE"]

  on_schema {
    all_schemas_in_database = snowflake_database.prod_db.name
  }
}

# Grant SELECT on all tables in all schemas in prod_db
resource "snowflake_grant_privileges_to_account_role" "dbt_service_access_role_select_all_tables" {
  account_role_name = snowflake_account_role.dbt_service_access_role.name
  privileges        = ["SELECT"]

  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_database        = snowflake_database.prod_db.name
    }
  }
}

# Grant SELECT on future tables in all schemas in prod_db
resource "snowflake_grant_privileges_to_account_role" "dbt_service_access_role_select_future_tables" {
  account_role_name = snowflake_account_role.dbt_service_access_role.name
  privileges        = ["SELECT"]

  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_database        = snowflake_database.prod_db.name
    }
  }
}

resource "snowflake_grant_account_role" "grant_dbt_service_functional_role_to_user" {
  role_name = snowflake_account_role.dbt_service_functional_role.name
  user_name = snowflake_user.DBT_ECS_USER.name
}