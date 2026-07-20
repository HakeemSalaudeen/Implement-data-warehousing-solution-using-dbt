resource "aws_ecr_repository" "dbt-test" {
  name                 = "dbt_test"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


data "aws_ecr_lifecycle_policy_document" "dbt-test" {
  rule {
    priority    = 1
    description = "To delete ecr images so that only the last 3 recent images are kept"
    action {
      type = "expire"
    }

    selection {
      tag_status   = "any"
      count_type   = "imageCountMoreThan"
      count_number = 3
    }
  }
}

resource "aws_ecr_lifecycle_policy" "dbt-test" {
  repository = aws_ecr_repository.dbt-test.name

  policy = data.aws_ecr_lifecycle_policy_document.dbt-test.json
}

