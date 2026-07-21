resource "aws_ecs_task_definition" "snowflake_poc_task" {
  family                   = "infra-snowflake-poc-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = data.aws_iam_role.snowflake_task_execution_role.arn
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "snowflake-poc-container",
    "environment": [
                    { "name": "account", "value": "HIEMLZO-BD72310" },
                    { "name": "user", "value": "HAKYMDEVV" },
                    { "name": "database", "value": "RAW" },
                    { "name": "schema", "value": "PUBLIC" },
                    { "name": "warehouse", "value": "COMPUTE_WH" },
                    { "name": "role", "value": "ACCOUNTADMIN" }
                    ],
              secrets = [
        {
          name      = "ELITE_KINGS_COUNTY_SNOWFLAKE_PASSWORD"
          valueFrom = data.aws_ssm_parameter.snowflake-poc-container.arn
        }
      ]
    "image": "${data.aws_ecr_image.snowflake_image.image_uri}",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-create-group": "true",
            "awslogs-group": "awslogs-snowflake-poc",
            "awslogs-region": "eu-central-1",
            "awslogs-stream-prefix": "snowflake-poc"
        }
    },
    "cpu": 1024,
    "memory": 2048,
    "essential": true
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

}

data "aws_ecr_image" "snowflake_image" {
  repository_name = aws_ecr_repository.dbt-test.name
  image_tag       = "latest"
}

data "aws_iam_role" "snowflake_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

resource "aws_iam_policy" "airflow_ecs_policy" {
  name        = "airflow-ecs-policy"
  description = "Allow all Elite Data Engineer Airflow users to run ECS dbt tasks"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "RunECSTasks"
        Effect = "Allow"
        Action = [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:CreateLogGroup"
        ]
        Resource = "*"
      }
    ]
  }
  )
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = data.aws_iam_role.snowflake_task_execution_role.name
  policy_arn = aws_iam_policy.airflow_ecs_policy.arn
}

resource "aws_ecs_cluster" "snowflake_poc_cluster" {
  name = "infra-snowflake-poc-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

}