# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name                 = "ebanking"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_db_subnet_group" "ebanking" {
  name       = "ebanking"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "ebanking"
  }
}

resource "aws_security_group" "rds" {
  name   = "ebanking_rds"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ebanking_rds"
  }
}

resource "aws_db_parameter_group" "ebanking" {
  name   = "ebanking"
  family = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

resource "aws_db_instance" "ebanking" {
  identifier             = "ebanking"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "mysql"
  //engine_version         = "14.1"
  username               = "edu"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.ebanking.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.ebanking.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}
