provider "aws" {
  region = "us-east-1"
}

# Local onde é armazenado o state do terraform
terraform {
  backend "s3" {
    bucket = "terraform-geru"
    key    = "state/data-lake/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

# Security Group da atrelado a VPC
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

#chamada do modulo VPC 
module "vpc" {
  source = "../../../modules/vpc"

  name = "data-lake"

  cidr = "10.10.0.0/16"

  azs                 = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets     = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnets      = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  
  public_subnet_tags = {
    Name = "data-lake-public"
  }

  private_subnet_tags = {
    Name = "data-lake-private"
  }

  public_route_table_tags = {
    Name = "data-lake-public"
  }

  private_route_table_tags = {
    Name = "data-lake-private"
  }

  tags = {
    Name = "data-lake"
  }
}