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
  default_role      = snowflake_account_role.data_team_functional_role.fully_qualified_name
  default_namespace = snowflake_schema.data_team_schema.fully_qualified_name

  must_change_password = "false"
  disable_mfa          = "false"
}