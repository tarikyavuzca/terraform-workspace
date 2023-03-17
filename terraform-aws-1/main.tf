# creating vpc named dev with given cidr 
resource "aws_vpc" "mtc_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}

# public subnet named dev-public
resource "aws_subnet" "mtc_public_subnet" {
  vpc_id                  = aws_vpc.mtc_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "dev-public"
  }
}

# internet gateway named dev-igw
resource "aws_internet_gateway" "mtc_igw" {
  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    Name = "dev-igw"
  }
}

# public route table
resource "aws_route_table" "mtc_public_rt" {
  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    Name = "dev_public_rt"
  }
}

# default route 
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.mtc_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mtc_igw.id
}

# public rt association
resource "aws_route_table_association" "mtc_public_association" {
  subnet_id      = aws_subnet.mtc_public_subnet.id
  route_table_id = aws_route_table.mtc_public_rt.id

}

# security group
resource "aws_security_group" "mtc_sg" {
  name        = "dev_sg"
  description = "dev security group"

  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    Name = "dev_sg"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }


}

resource "aws_key_pair" "mtc_auth" {
  key_name   = "tempkey"
  public_key = file("~/.ssh/tempkey.pub")

}


resource "aws_instance" "mtc_instance" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.mtc_ami.id
  key_name               = aws_key_pair.mtc_auth.id
  vpc_security_group_ids = [aws_security_group.mtc_sg.id]
  subnet_id              = aws_subnet.mtc_public_subnet.id
  user_data = "${file("userdata.sh")}"

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "dev-node"
  }
}

output "aws_ec2_public_ip" {
  value = aws_instance.mtc_instance.public_ip
  
}