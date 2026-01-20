resource "aws_iam_user" "users" {
  for_each = toset(var.users_name)
  name     = each.value
  path = "/system/"
}

resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "*"
      },

      {
        Effect = "Allow"
        Action  = "ec2:*"
        Resource = "*"
      },

      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:BatchGetItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:DescribeTable",
          "dynamodb:ListTables"
        ]
        Resource = "*"
      },

      {
        Effect = "Allow"
        Action = [
          "eks:Create*",
          "eks:Update*",
          "eks:Delete*",
          "eks:Describe*",
          "eks:List*",
          "eks:AccessKubernetesApi"
        ]
        Resource = "*"
      },

      {
        Effect = "Allow"
        Action = [
          "rds:Describe*",
          "rds:ListTagsForResource"
        ]
        Resource  = "*"
      }
    ]
  })
}

resource "aws_iam_role" "role" {
  name               = "developer_role"
  assume_role_policy = aws_iam_policy.policy.arn
}

resource "aws_iam_user_policy" "assume_role_policy" {
  for_each = aws_iam_user.users
  name = "assume-role-policy"
  user = each.key

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Resource = aws_iam_role.role.arn
      }
    ]
  })
}




