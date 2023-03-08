

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



# check aws to see newly created ec2 instance by terraform

