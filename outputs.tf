# VPC flow log - Cloudwatch logs
output "flow_log_group_name" {
  value = aws_cloudwatch_log_group.flow_log_group.name
}

output "flow_log_group_arn" {
  value = aws_cloudwatch_log_group.flow_log_group.arn
}