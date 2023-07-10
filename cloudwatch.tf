# Creates a CloudWatch log group for VPC flow logs with a retention period of 1 day.
resource "aws_cloudwatch_log_group" "flow_log_group" {
  name = "/aws/vpc-flow-logs"
  retention_in_days = 1
}

# Creates a flow log for VPC traffic and associates it with the CloudWatch log group.
resource "aws_flow_log" "vpc_flow_log" {
  iam_role_arn    = aws_iam_role.flow_log_role.arn
  log_destination = aws_cloudwatch_log_group.flow_log_group.arn
  traffic_type    = "ACCEPT"
  vpc_id          = aws_vpc.main.id
  #flow_direction  = ingress

  depends_on = [aws_cloudwatch_log_group.flow_log_group]
}

# Creates a CloudWatch metric alarm for VPC access based on flow log records.
resource "aws_cloudwatch_metric_alarm" "access_alarm" {
  alarm_name          = "VPC Access Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "flow_log_records"
  namespace           = "AWS/Logs"
  period              = "60"
  statistic           = "SampleCount"
  threshold           = "1"
  alarm_description   = "Alarm triggered for VPC access"
  alarm_actions       = [aws_sns_topic.notification_topic.arn]

  dimensions = {
    LogGroupName = aws_cloudwatch_log_group.flow_log_group.name
  }
}

resource "aws_sns_topic" "notification_topic" {
  name = "vpc-access"
}

# Subscribes an email endpoint to the SNS topic for VPC access notifications.
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.notification_topic.arn
  protocol  = "email"
  endpoint  = var.sns_email
}