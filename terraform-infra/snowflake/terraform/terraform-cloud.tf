terraform {
  #required_version = "1.15.3"

  cloud {

    organization = "hakym-dev-project"

    workspaces {
      name = "snowflake-playground"
    }
  }
}