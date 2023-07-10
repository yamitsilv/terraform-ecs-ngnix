terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~>3.0.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
    }
  }
  
  required_version = ">= 1.2.0"
}

# Configuring AWS as the provider
provider "aws" {
  region = var.aws_region
}

# Configuring Docker as the provider
provider "docker" {}

resource "aws_instance" "app_server" {
  ami           = "ami-6f68cf0f"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

# Creating an ECS cluster
resource "aws_ecs_cluster" "cluster" {
  name = "cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# Creating an ECS task definition
resource "aws_ecs_task_definition" "task" {
  family                   = "service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE", "EC2"]
  cpu                      = 512
  memory                   = 2048

  container_definitions = jsonencode([
    {
      name: "nginx",
      image: "nginxdemos/hello",
      cpu: 512,
      memory: 2048,
      essential: true,
      portMappings: [
        {
          containerPort: 80,
          hostPort: 80,
        },
      ],
    },
  ])
}

# Creating an ECS service
resource "aws_ecs_service" "service" {
  name             = "service"
  cluster          = aws_ecs_cluster.cluster.id
  task_definition  = aws_ecs_task_definition.task.arn
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = [aws_subnet.public_subnet.id]
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}
