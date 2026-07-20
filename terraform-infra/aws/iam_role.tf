resource "aws_iam_role_policy" "snowflake-stage_policy" {
  name = "snowflake-stage_policy"
  role = aws_iam_role.snowflake-stage_role.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:GetObjectVersion"
            ],
            "Resource": "arn:aws:s3:::snowflake-stage-test-bucket-2026/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": "arn:aws:s3:::snowflake-stage-test-bucket-2026"
        }
    ]
})
}

# resource "aws_iam_role" "snowflake-stage_role" {
#   name = "snowflake_stage_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = "SnowflakeStageAssumeRole"
#         Principal = {
#           Service = "s3.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

resource "aws_iam_role" "snowflake-stage_role" {
  name = "snowflake_stage_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "SnowflakeStageAssumeRole"
        Effect = "Allow"
        Principal = {
          # Paste your STORAGE_AWS_IAM_USER_ARN below
          AWS = ["arn:aws:iam::260289090760:user/3ibp1000-s", 
                  "arn:aws:iam::650012445037:user/jh7t1000-s"]
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            # Paste your STORAGE_AWS_EXTERNAL_ID below
            "sts:ExternalId" = ["FR31028_SFCRole=3_lN48cbU5/8q+Rlug39X5P2BfjSk=",
                                "HY46367_SFCRole=331_OqZMzNejVXQvVz6p4JwCry3V/tk="]
          }
        }
      }
    ]
  })
}
