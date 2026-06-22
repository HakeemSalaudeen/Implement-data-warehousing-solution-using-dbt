# # resource "snowflake_warehouse" "sf_tuts" {
# #   name                                = "sf_tuts"
# #   warehouse_type                      = "SNOWPARK-OPTIMIZED"
# #   warehouse_size                      = "X-SMALL"
# #   max_cluster_count                   = 4
# #   min_cluster_count                   = 2
# #   scaling_policy                      = "ECONOMY"
# #   auto_suspend                        = 1200
# #   auto_resume                         = false
# #   initially_suspended                 = false
# #   resource_monitor                    = snowflake_resource_monitor.monitor.fully_qualified_name
# #   comment                             = "An example warehouse."
# #   enable_query_acceleration           = true
# #   query_acceleration_max_scale_factor = 4
# #   resource_constraint                 = "MEMORY_16X"

# #   max_concurrency_level               = 4
# #   statement_queued_timeout_in_seconds = 5
# #   statement_timeout_in_seconds        = 86400
# # }


# resource "snowflake_warehouse" "sf_tuts-warehouse" {
#   name           = "sf_tuts"
#   warehouse_type = "STANDARD"
#   warehouse_size = "X-SMALL"
#   # generation     = "2"
#   auto_suspend   = 180
#   auto_resume    = true
#   initially_suspended = true
#   comment = "sf_tuts warehouse."
# }

# resource "snowflake_stage_internal" "sf_tuts-stage" {
#   name     = "my_internal_stage"
#   database = snowflake_database.sf_tuts-database.name
#   schema   = snowflake_schema.sf_tuts-schema.name
#   comment  = "sf_tuts stage."
# }

# resource "snowflake_database" "sf_tuts-database" {
#   name = "sf_tuts"
# }

# resource "snowflake_schema" "sf_tuts-schema" {
#   database            = snowflake_database.sf_tuts-database.name
#   name                = "public"
# }

# resource "snowflake_sequence" "sf_tuts-sequence" {
#   database = snowflake_schema.sf_tuts-schema.database
#   schema   = snowflake_schema.sf_tuts-schema.name
#   name     = "sf_tuts_sequence"
# }

# resource "snowflake_table" "sf_tuts-table" {
#   database                    = snowflake_schema.sf_tuts-schema.database
#   schema                      = snowflake_schema.sf_tuts-schema.name
#   name                        = "emp_basic"
#   comment                     = "sf_tuts table."
#   # cluster_by                  = ["to_date(DATE)"]
#   # data_retention_time_in_days = snowflake_schema.sf_tuts-schema.data_retention_time_in_days
#   # change_tracking             = false

#   column {
#     name     = "first_name"
#     type     = "string"
#     nullable = false

#     # default {
#     #   sequence = snowflake_sequence.sf_tuts-sequence.fully_qualified_name
#     # }
#   }

#     column {
#     name     = "last_name"
#     type     = "string"
#     nullable = false
#   }

#   column {
#     name     = "email"
#     type     = "string"
#     nullable = true
#   }

#   column {
#     name     = "streetaddress"
#     type     = "string"
#     nullable = true
#   }

#   column {
#     name     = "city"
#     type     = "string"
#     nullable = true
#   }

#   column {
#     name = "start_date"
#     type = "DATE"
#   }
# }
