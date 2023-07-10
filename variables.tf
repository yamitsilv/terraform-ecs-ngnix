# Provider configuration variables
variable "aws_region" {
  description = "AWS region to use"
  type        = string
  default     = "us-west-2"
}

# VPC configuration variables
variable "vpc_cidr" {
  description = "CIDR block for main VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Availability zones configuration variable
variable "availability_zones" {
  description = "AWS availability zones to use"
  type        = list(string)
  default     = ["us-west-2a"]
}

# Email Address configuration for CloudWatch alarms
variable "sns_email" {
  description = "Email Address for CloudWatch alarms"
  type        = string
  default     = "yamitaws@gmail.com"
}