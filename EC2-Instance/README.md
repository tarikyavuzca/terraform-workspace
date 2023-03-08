# Steps 

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



# run command "terraform init" to initialize
# run command "terraform plan" to initialize
# run command "terraform apply" to initialize


# check aws to see newly created ec2 instance by terraform