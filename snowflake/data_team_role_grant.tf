resource "snowflake_grant_privileges_to_account_role" "data_team_access_role_warehouse_usage" {
  account_role_name = snowflake_account_role.data_team_access_role.name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.lsa-warehouse.name
  }
}

# Grant the USAGE privilege on the prod_db database to the access role
resource "snowflake_grant_privileges_to_account_role" "data_team_access_role_prod_db_usage" {
  account_role_name = snowflake_account_role.data_team_access_role.name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.prod_db.name
  }
}

# Grant the USAGE privilege on the data_team_schema schema to the access role
resource "snowflake_grant_privileges_to_account_role" "data_team_access_role_schema_usage" {
  account_role_name = snowflake_account_role.data_team_access_role.name
  privileges        = ["USAGE"]

  on_schema {
    schema_name = snowflake_schema.data_team_schema.fully_qualified_name
  }
}

# grant select on all tables in the data_team_schema to the access role
resource "snowflake_grant_privileges_to_account_role" "data_team_access_role_select_all_tables" {
  account_role_name = snowflake_account_role.data_team_access_role.name
  privileges        = ["SELECT"]

  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.data_team_schema.fully_qualified_name
    }
  }
}

# grant select on future tables in the data_team_schema to the access role
resource "snowflake_grant_privileges_to_account_role" "data_team_access_role_select_future_tables" {
  account_role_name = snowflake_account_role.data_team_access_role.name
  privileges        = ["SELECT"]

  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.data_team_schema.fully_qualified_name
    }
  }
}

resource "snowflake_grant_account_role" "abdulhakeem_role_to_user" {
  role_name = snowflake_account_role.data_team_functional_role.name
  user_name = snowflake_user.abdulhakeem_data_team_user.name
}