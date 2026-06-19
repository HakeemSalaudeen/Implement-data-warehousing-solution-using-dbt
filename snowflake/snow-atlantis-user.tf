resource "snowflake_user" "git-test" {
  name = "Snowflake_atlantis_git_test1"
}


resource "snowflake_user" "atlantis" {
  name         = "Snowflake atlantis"
  login_name   = var.login_name
  first_name   = var.first_name
  middle_name  = var.middle_name
  last_name    = var.last_name
  comment      = "atlantis of snowflake."
  password     = var.password
  disabled     = "false"
  display_name = "Snowflake atlantis"
  #email        = var.email

#   default_warehouse              = snowflake_warehouse.example.fully_qualified_name
#   default_secondary_roles_option = "ALL"
#   default_role                   = snowflake_role.example.fully_qualified_name
#   default_namespace              = "some.namespace"

  # mins_to_unlock     = 9
  # days_to_expiry     = 8
  # mins_to_bypass_mfa = 10

#   rsa_public_key   = "..."
#   rsa_public_key_2 = "..."

  must_change_password = "false"
  disable_mfa          = "false"
}

# ## atlantis role 
# resource "snowflake_account_role" "atlantis_role" {
#   name    = "atlantis_role"
#   comment = "Role for Atlantis infrastructure deployment"
# }

# resource "snowflake_grant_account_role" "atlantis_role_to_user" {
#   role_name = snowflake_account_role.atlantis_role.name
#   user_name = snowflake_user.atlantis.name
# }

# resource "snowflake_grant_account_role" "atlantis_sysadmin_grant" {
#   role_name        = "SYSADMIN"
#   parent_role_name = snowflake_account_role.atlantis_role.name
# }

# resource "snowflake_grant_account_role" "atlantis_useradmin_grant" {
#   role_name        = "USERADMIN"
#   parent_role_name = snowflake_account_role.atlantis_role.name
# }

# # Your custom atlantis role
# # resource "snowflake_account_role" "atlantis_role" {
# #   name    = "atlantis_role"
# #   comment = "Role for Atlantis infrastructure deployment"
# # }

# # # Grant system roles to atlantis_role
# # resource "snowflake_role_grant" "atlantis_grant_sysadmin" {
# #   role_name    = snowflake_account_role.atlantis_role.name
# #   granted_role = "SYSADMIN"
# # }

# # resource "snowflake_role_grant" "atlantis_grant_useradmin" {
# #   role_name    = snowflake_account_role.atlantis_role.name
# #   granted_role = "USERADMIN"
# # }

# # # Grant atlantis_role to the atlantis user (already have this)
# # resource "snowflake_grant_account_role" "atlantis_role_to_user" {
# #   role_name = snowflake_account_role.atlantis_role.name
# #   user_name = snowflake_user.atlantis.name
# # }


