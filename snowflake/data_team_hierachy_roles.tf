# # CREATE ROLE access_role_data_team;
# # CREATE ROLE access_role_ml_team;
# # CREATE ROLE access_role_finance_team;
# # CREATE ROLE access_role_service_account;
# # CREATE ROLE data_team;
# # CREATE ROLE ml_team;
# # CREATE ROLE finance_team;
# # GRANT ROLE access_role_data_team TO ROLE data_team;
# # GRANT ROLE access_role_ml_team TO ROLE ml_team;
# # GRANT ROLE access_role_finance_team TO ROLE finance_team;
# # GRANT ROLE access_role_service_account TO ROLE atlantis_role;



## data team hierarchy roles 
resource "snowflake_account_role" "data_team_access_role" {
  name    = "DATA_TEAM_ACCESS_ROLE"
  comment = "Access role that permits read-only access to tables in the data_team_schema"
}

resource "snowflake_account_role" "data_team_functional_role" {
  name    = "DATA_TEAM_FUNCTIONAL_ROLE"
  comment = "Functional role that permits read-only access to tables in the data_team_schema"
}

resource "snowflake_grant_account_role" "data_team_access_role_to_functional_role" {
  role_name        = snowflake_account_role.data_team_access_role.name
  parent_role_name = snowflake_account_role.data_team_functional_role.name
}

resource "snowflake_grant_account_role" "data_team_functional_role_to_sysadmin" {
  role_name        = snowflake_account_role.data_team_functional_role.name
  parent_role_name = "SYSADMIN"
}

