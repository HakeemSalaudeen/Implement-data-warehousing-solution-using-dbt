locals {
  data_team_roles = toset([
    snowflake_account_role.data_analyst_role.name,
    snowflake_account_role.data_engineer_role.name,
  ])
}

# Grant the USAGE privilege on the lsa-warehouse warehouse to both roles
resource "snowflake_grant_privileges_to_account_role" "data_team_access_role_warehouse_usage" {
  for_each = local.data_team_roles

  account_role_name = each.value
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.lsa-warehouse.name
  }
}

# Grant the USAGE privilege on the prod_db database to both roles
resource "snowflake_grant_privileges_to_account_role" "data_team_access_role_prod_db_usage" {
  for_each = local.data_team_roles

  account_role_name = each.value
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.prod_db.name
  }
}

# Grant the USAGE privilege on the data_team_schema schema to both roles
resource "snowflake_grant_privileges_to_account_role" "data_team_access_role_schema_usage" {
  for_each = local.data_team_roles

  account_role_name = each.value
  privileges        = ["USAGE"]

  on_schema {
    schema_name = snowflake_schema.data_team_schema.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "data_engineer_role_schema_usage" {
  account_role_name = snowflake_account_role.data_engineer_role.name
  privileges        = ["USAGE"]

  on_schema {
    schema_name = snowflake_schema.bronze_schema.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "data_engineer_role_select_all_tables" {
  account_role_name = snowflake_account_role.data_engineer_role.name
  privileges        = ["SELECT"]

  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.bronze_schema.fully_qualified_name
    }
  }
}

# Grant SELECT on all tables in the data_team_schema to both roles
resource "snowflake_grant_privileges_to_account_role" "data_team_role_select_all_tables" {
  for_each = local.data_team_roles

  account_role_name = each.value
  privileges        = ["SELECT"]

  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.data_team_schema.fully_qualified_name
    }
  }
}

# Grant SELECT on future tables in the data_team_schema to both roles
resource "snowflake_grant_privileges_to_account_role" "data_team_access_role_select_future_tables" {
  for_each = local.data_team_roles

  account_role_name = each.value
  privileges        = ["SELECT"]

  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.data_team_schema.fully_qualified_name
    }
  }
}


#  Grant SELECT on all EXTERNAL TABLES specifically
resource "snowflake_grant_privileges_to_account_role" "data_engineer_role_select_all_external_tables" {
  account_role_name = snowflake_account_role.data_engineer_role.name
  privileges        = ["SELECT"]

  on_schema_object {
    all {
      object_type_plural = "EXTERNAL TABLES"
      in_schema          = snowflake_schema.bronze_schema.fully_qualified_name
    }
  }
}

#  Grant USAGE on the external stage so they can read the underlying data
resource "snowflake_grant_privileges_to_account_role" "data_engineer_role_stage_usage" {
  account_role_name = snowflake_account_role.data_engineer_role.name
  privileges        = ["USAGE"]

  on_schema_object {
    object_type = "STAGE"
    object_name = snowflake_stage_external_s3.lsa_external_stage.fully_qualified_name
  }
}


resource "snowflake_grant_privileges_to_account_role" "data_engineer_role_schema_privileges" {
  account_role_name = snowflake_account_role.data_engineer_role.name
  privileges = [
    "USAGE",
    "CREATE TABLE",
    "CREATE VIEW",
    "CREATE STAGE",
    "CREATE FUNCTION",
    "MODIFY"
  ]

  on_schema {
    all_schemas_in_database = snowflake_database.prod_db.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "data_engineer_role_future_schema_privileges" {
  account_role_name = snowflake_account_role.data_engineer_role.name
  privileges = [
    "USAGE",
    "CREATE TABLE",
    "CREATE VIEW",
    "CREATE STAGE",
    "CREATE FUNCTION",
    "MODIFY"
  ]

  on_schema {
    future_schemas_in_database = snowflake_database.prod_db.name
  }
}