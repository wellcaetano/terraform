provider "aws" {
  region = "us-east-1"
}

# Local onde é armazenado o state do terraform
terraform {
  backend "s3" {
    bucket = "terraform-delta"
    key    = "state/data-lake/vpc_peering/terraform.tfstate"
    region = "us-east-1"
  }
}

# Modulo para conexão dos peerings
module "vpc_peering" {
  source = "../../../modules/vpc/modules/vpc_peering_requester"
  vpc_accepter_id = "vpc-057280d896d7aff55"
  destination_network = "10.177.0.0/16"
  tags = {
    Name = "data-lake"
  }
}