resource "snowflake_warehouse" "dbt-compute-warehouse" {
  name                = "DBT_COMPUTE_WH"
  warehouse_type      = "STANDARD"
  warehouse_size      = "X-SMALL"
  auto_suspend        = 60
  auto_resume         = true
  initially_suspended = true
  comment             = "DBT COMPUTE WH"
}