# ## Complete database (with every optional set)
resource "snowflake_database" "prod_db" {
  name         = "PROD_DB"
  is_transient = false
  comment      = "LSA PROD DB"

  data_retention_time_in_days     = 1
  max_data_extension_time_in_days = 20
  drop_public_schema_on_creation  = true
  replace_invalid_characters      = false
}


resource "snowflake_warehouse" "lsa-warehouse" {
  name                = "LSA_COMPUTE_WH"
  warehouse_type      = "STANDARD"
  warehouse_size      = "X-SMALL"
  auto_suspend        = 60
  auto_resume         = true
  initially_suspended = true
  comment             = "LSA COMPUTE WH"
}


resource "snowflake_schema" "data_team_schema" {
  name     = "DATA_TEAM_SCHEMA"
  database = snowflake_database.prod_db.name
  comment  = "schema for data team"
}


resource "snowflake_schema" "bronze_schema" {
  name     = "BRONZE_LAYER_SCHEMA"
  database = snowflake_database.prod_db.name
  comment  = "bronze schema for data team"
}

resource "snowflake_schema" "silver_schema" {
  name     = "SILVER_LAYER_SCHEMA"
  database = snowflake_database.prod_db.name
  comment  = "silver schema for data team"
}

resource "snowflake_schema" "gold_schema" {
  name     = "GOLD_LAYER_SCHEMA"
  database = snowflake_database.prod_db.name
  comment  = "gold schema for data team"
}


resource "snowflake_table" "lsa_internal_table" {
  database                    = snowflake_schema.bronze_schema.database
  schema                      = snowflake_schema.bronze_schema.name
  name                        = "BRONZE_LAYER_INTERNAL_TABLE"
  comment                     = "Internal table for LSA project."
  column {
    name = "SalesOrderNumber"
    type = "VARCHAR"
  }

  column {
    name = "SalesOrderLineNumber"
    type = "VARCHAR"
  }

  column {
    name = "OrderDate"
    type = "VARCHAR"
  }

  column {
    name = "CustomerName"
    type = "VARCHAR"
  }

  column {
    name = "Email"
    type = "VARCHAR"
  }

  column {
    name = "Item"
    type = "VARCHAR"
  }

  column {
    name = "Quantity"
    type = "VARCHAR"
  }

  column {
    name = "UnitPrice"
    type = "VARCHAR"
  }

  column {
    name = "Tax"
    type = "VARCHAR"
  }
}

# resource "snowflake_schema" "testing_schema" {
#   name     = "TESTING_SCHEMA"
#   database = snowflake_database.prod_db.name
#   comment  = "testing schema for data team"
# }