terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-northeast-1"
}

resource "aws_instance" "terraform-ec2-01" {
  ami                         = "ami-0d3bbfd074edd7acb"
  availability_zone           = "ap-northeast-1a"
  instance_type               = "t2.micro"
  key_name                    = "ryu-keypair"
  subnet_id                   = "subnet-0800a87b98300de9a"
  vpc_security_group_ids      = "sg-0f71a7b494e9d854b"
  associate_public_ip_address = false
  private_ip                  = "10.3.2.111"
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }
  tags = {
    "Name" = "terraform-ec2-01"
  }
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_eip" "ec2-eip" {
  instance = aws_instance.terraform-ec2-01.id
  vpc      = true
}
