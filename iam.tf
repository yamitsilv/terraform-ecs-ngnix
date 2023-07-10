# IAM role for VPC flow logs with a policy allowing VPC flow logs service to assume the role.
resource "aws_iam_role" "flow_log_role" {
  name = "flow_log_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# IAM role policy that grants permissions for creating and managing CloudWatch log groups and streams.
resource "aws_iam_role_policy" "flow_log_role_policy" {
  name = "flow_log_role_policy"
  role = aws_iam_role.flow_log_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}