### Steps ###

# Launch an EC2 instance with SSH access SG
# Connect EC2 instance with SSH
/* User data
#!bin/bash
sudo yum update -y
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
terraform version
*/
# create an IAM role in aws console (AmazonEC2FullAccess) and modify for EC2 instance
# now our EC2 instance has permission to create EC2 instance

# run these commands
# mkdir terraform && cd terraform && touch main.tf

# terraform block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.57.1"
    }
  }
}

# access key,secret key is not a good practice (incase you can not provide IAM role)
# provider block
provider "aws" {
  region  = "us-east-1"
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"
}

# resource block
resource "aws_instance" "tf-ec2" {
  ami           = "ami-006dcf34c09e50022"
  instance_type = "t2.micro"
  tags = {
    "Name" = "created-by-tf"
  }
}

# run command "terraform init" to initialize
# run command "terraform plan" to initialize
# run command "terraform apply" to initialize

# check aws to see newly created ec2 instance by terraform

