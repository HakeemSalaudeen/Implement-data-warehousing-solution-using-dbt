resource "snowflake_storage_integration_aws" "lsa_storage_integration" {
  name                      = "LSA_AWS_S3_STORAGE_INTEGRATION"
  enabled                   = true
  storage_provider          = "S3"
  storage_allowed_locations = ["s3://snowflake-stage-test-bucket-2026/sales/"]
  # storage_blocked_locations = ["s3://mybucket1/blocked-location/", "s3://mybucket1/blocked-location2/"]
  # use_privatelink_endpoint  = "true"
  comment = "Storage integration for LSA project to connect to S3 buckets"

  storage_aws_role_arn = var.aws_role_arn
  #storage_aws_external_id = "some_external_id"
  #storage_aws_object_acl  = "bucket-owner-full-control"
}


resource "snowflake_stage_external_s3" "lsa_external_stage" {
  name                = "LSA_EXTERNAL_STAGE"
  database            = snowflake_database.prod_db.name
  schema              = snowflake_schema.bronze_schema.name
  url                 = "s3://snowflake-stage-test-bucket-2026/sales/"
  storage_integration = snowflake_storage_integration_aws.lsa_storage_integration.name

  directory {
    enable            = true
    refresh_on_create = true
    auto_refresh      = false
  }

  comment = "LSA external stage for S3 bucket."
}


resource "snowflake_file_format" "lsa_file_format" {
  name            = "LSA_FILE_FORMAT"
  database        = snowflake_database.prod_db.name
  schema          = snowflake_schema.bronze_schema.name
  format_type     = "CSV"
  comment         = "File format for LSA project external table."
  field_delimiter = ","
  skip_header     = 0
}


resource "snowflake_external_table" "lsa_external_table" {
  database     = snowflake_database.prod_db.name
  schema       = snowflake_schema.bronze_schema.name
  name         = "BRONZE_LAYER_EXTERNAL_TABLE"
  location     = "@${snowflake_stage_external_s3.lsa_external_stage.fully_qualified_name}"
  #file_format  = snowflake_file_format.lsa_file_format.fully_qualified_name
  #file_format  = (FORMAT_NAME = "PROD_DB.BRONZE_LAYER_SCHEMA.LSA_FILE_FORMAT")
  file_format  = "TYPE = CSV, SKIP_HEADER = 0, FIELD_DELIMITER = ',', NULL_IF = ('NULL', 'null')"
  auto_refresh = true
  comment      = "External table for LSA project with location specified."
  #partition_by = ["OrderDate"]
  table_format = "DELTA"
  column {
    name = "SalesOrderNumber"
    type = "VARCHAR"
    as   = "value:c1::VARCHAR"
  }

  column {
    name = "SalesOrderLineNumber"
    type = "VARCHAR"
    as   = "value:c2::VARCHAR"
  }

  column {
    name = "OrderDate"
    type = "VARCHAR"
    as   = "value:c3::VARCHAR"
  }

  column {
    name = "CustomerName"
    type = "VARCHAR"
    as   = "value:c4::VARCHAR"
  }

  column {
    name = "Email"
    type = "VARCHAR"
    as   = "value:c5::VARCHAR"
  }

  column {
    name = "Item"
    type = "VARCHAR"
    as   = "value:c6::VARCHAR"
  }

  column {
    name = "Quantity"
    type = "VARCHAR"
    as   = "value:c7::VARCHAR"
  }

  column {
    name = "UnitPrice"
    type = "VARCHAR"
    as   = "value:c8::VARCHAR"
  }

  column {
    name = "Tax"
    type = "VARCHAR"
    as   = "value:c9::VARCHAR"
  }
}