# variable "email" {
#   type      = string
#   sensitive = true
# }

variable "login_name" {
  type        = string
  sensitive   = true
  description = "login name"
}

variable "password" {
  type        = string
  sensitive   = true
  description = "Password for the Atlantis user. Must be at least 12 characters long."

  validation {
    condition     = length(var.password) >= 12
    error_message = "Password must be at least 12 characters long."
  }
}

variable "first_name" {
  type        = string
  sensitive   = true
  description = "First name of the Atlantis user."
}

variable "middle_name" {
  type        = string
  sensitive   = true
  description = "Middle name of the Atlantis user."
}

variable "last_name" {
  type        = string
  sensitive   = true
  description = "Last name of the Atlantis user."
}


# variable "organization_name" {
#   type      = string
#   sensitive = true
#    description = "Name of the organization."
# }

# variable "account_name" {
#   type      = string
#   sensitive = true
#    description = "Name of the account."
# }

# variable "user" {
#   type      = string
#   sensitive = true
#    description = "Username for Snowflake authentication."
# }

# variable "cloud_password" {
#   type      = string
#   sensitive = true
#    description = "Password for Snowflake authentication."
# }

# variable "role" {
#   type      = string
#   sensitive = true
#    description = "Role for Snowflake authentication."
# }


variable "abdulhakeem_password" {
  type        = string
  sensitive   = true
  description = "Password for the abdulhakeem data team user. Must be at least 12 characters long."

  validation {
    condition     = length(var.abdulhakeem_password) >= 12
    error_message = "Password must be at least 12 characters long."
  }
}

variable "aws_role_arn" {
  type        = string
  sensitive   = true
  description = "aws_role_arn"
}