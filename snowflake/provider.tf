terraform {
  required_providers {
    snowflake = {
      source = "snowflakedb/snowflake"
    }
  }
}

variable "organization_name" { type = string }
variable "account_name" { type = string }
variable "user" { type = string }
variable "cloud_password" { type = string }
variable "role" { type = string }

# A simple configuration of the provider with a default authentication.
# A default value for `authenticator` is `snowflake`, enabling authentication with `user` and `password`.
provider "snowflake" {
  organization_name = var.organization_name
  account_name      = var.account_name
  user              = var.user
  password          = var.cloud_password
  role              = var.role

  preview_features_enabled = [
    "snowflake_stage_internal_resource",
    "snowflake_sequence_resource",
    "snowflake_table_resource"
  ]
}