resource "aws_s3_bucket" "snowflake-stage-test" {
  bucket        = "snowflake-stage-test-bucket-2026"
  force_destroy = true

  tags = {
    Name        = "snowflake-stage-log-bucket"
    Environment = "test"
    Date        = "2026-06-09"
  }
}