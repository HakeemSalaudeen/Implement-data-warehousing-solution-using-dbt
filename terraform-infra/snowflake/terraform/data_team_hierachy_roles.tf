## data team hierarchy roles 
resource "snowflake_account_role" "data_team_role" {
  name    = "DATA_TEAM_ROLE"
  comment = "Access role that permits read-only access to tables in the data_team_schema"
}

resource "snowflake_account_role" "data_analyst_role" {
  name    = "DATA_ANALYST_ROLE"
  comment = "Data analyst role that permits read-only access to tables in the data_team_schema"
}

resource "snowflake_account_role" "data_engineer_role" {
  name    = "DATA_ENGINEER_ROLE"
  comment = "Data engineer role that permits read-only access to tables in the data_team_schema"
}

resource "snowflake_grant_account_role" "data_analyst_role_to_data_team_role" {
  role_name        = snowflake_account_role.data_analyst_role.name
  parent_role_name = snowflake_account_role.data_team_role.name
}

resource "snowflake_grant_account_role" "data_engineer_role_to_data_team_role" {
  role_name        = snowflake_account_role.data_engineer_role.name
  parent_role_name = snowflake_account_role.data_team_role.name
}

resource "snowflake_grant_account_role" "data_team_role_to_sysadmin" {
  role_name        = snowflake_account_role.data_team_role.name
  parent_role_name = "SYSADMIN"
}

