resource "snowflake_user" "abdulhakeem_data_team_user" {
  name       = "ABDULHAKEEM_DATA_TEAM_USER"
  login_name = "ASALAUDEEN"
  first_name = "abdulhakeem"
  #middle_name  = var.middle_name
  last_name    = "salaudeen"
  comment      = "user for abdulhakeem in datateam"
  password     = var.abdulhakeem_password
  disabled     = "false"
  display_name = "ABDULHAKEEM_DATA_TEAM_USER"
  email        = "abdulhakeem.salaudeen@company.com"

  default_warehouse = snowflake_warehouse.lsa-warehouse.fully_qualified_name
  default_role      = snowflake_account_role.data_engineer_role.name
  default_namespace = snowflake_schema.data_team_schema.fully_qualified_name

  must_change_password = "false"
  disable_mfa          = "false"
}


resource "snowflake_grant_account_role" "abdulhakeem_role_to_user" {
  role_name = snowflake_account_role.data_engineer_role.name
  user_name = snowflake_user.abdulhakeem_data_team_user.name
}


resource "snowflake_user" "oluwatobi_data_analyst_user" {
  name       = "OLUWATOBI_DATA_ANALYST_USER"
  login_name = "OSALAUDEEN"
  first_name = "oluwatobi"
  #middle_name  = var.middle_name
  last_name    = "salaudeen"
  comment      = "user for oluwatobi in dataanalyst role"
  password     = var.abdulhakeem_password
  disabled     = "false"
  display_name = "OLUWATOBI_DATA_ANALYST_USER"
  email        = "oluwatobi.salaudeen@company.com"

  default_warehouse = snowflake_warehouse.lsa-warehouse.fully_qualified_name
  default_role      = snowflake_account_role.data_analyst_role.name
  default_namespace = snowflake_schema.data_team_schema.fully_qualified_name

  must_change_password = "false"
  disable_mfa          = "false"
}

resource "snowflake_grant_account_role" "oluwatobi_role_to_user" {
  role_name = snowflake_account_role.data_analyst_role.name
  user_name = snowflake_user.oluwatobi_data_analyst_user.name
}