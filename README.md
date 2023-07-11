# Terraform ECS - Ngnix
Terraform ECS with Ngnix that serves "hello world" and VPC Flow Logs.
This repository contains Terraform templates to create an ECS (Elastic Container Service) cluster with an NGINX container, along with VPC Flow Logs enabled for network traffic monitoring.

## Prerequisites

Before using these Terraform templates, ensure that you have the following prerequisites installed and set:

- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/)
- AWS Account and credentials of an IAM User with permissions to apply terraform using AWS cli.

## Getting Started

1. Clone this repository:

```shell
git clone https://github.com/yamitsilv/terraform-ecs-ngnix.git
```

1. Change into the cloned directory:

```shell
cd terraform-ecs-ngnix.git
```
1. Set AWS cli with Access Key ID, Secret Acess key and default region - [AWS Authentication](https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-user.html).

1. Initialize the Terraform configuration:

```shell
terraform init
```

1. Review the variables.tf file and customize the variables according to your requirements, such as region, VPC CIDR block, availability zones and email address.

2. Apply the Terraform configuration to create the ECS cluster and enable VPC Flow Logs:

```shell
terraform apply --auto-approve
```
1. Locate the email titled "AWS Notification - Subscription Confirmation" in your inbox and click on the approval link.

1. Once the Terraform apply is complete, you will have an ECS cluster with an NGINX container deployed, and VPC Flow Logs enabled for network traffic monitoring.

## Cleanup

To clean up and destroy the resources created by Terraform, run the following command:

```shell
terraform destroy --auto-approve
```

Note: The terraform destroy command will delete all the resources created by Terraform, including the ECS cluster and VPC Flow Logs. Proceed with caution.

## Further Improvements

#### Alarms: 

Alarms issue can be fixed by:
- Adjusting Metrics configuration
- Forwarding Ngnix logs to CloudWatch instead of VPC flow logs

#### Security Hardening: 

Additional security measures would be:
- Applying security group rules to limit inbound and outbound traffic.
- Encrypting the web traffic using HTTPS with a SSL/TLS certificate from a trusted CA.
- Enabling encryption between containers and concidering isolation using EKS with sidecar.
- Applying additional configuration to secure ngnix by running a script or preparing an image with:
  1. HTTP Strict Transport Security  (HSTS).
  2. Disabling weak SSL/TLS protocols such as SSLv2, SSLv3, and TLSv1.0.
  3. Disabling unnecessary modules.
  4. Limiting request rates.
  5. Use Content Security Policy (CSP).

  
#### Automation:

- Setting aws login information in keys.tfvars file
- Creating a script to attempt to install prerequisits, accept parametes for optional variables modification and attempt to run terraform apply
