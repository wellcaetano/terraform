provider "aws" {
  region = "us-east-1"
}

# Local onde é armazenado o state do terraform
terraform {
  backend "s3" {
    bucket = "terraform-geru"
    key    = "state/data-lake/vpc_peering/geru-prod-sa/terraform.tfstate"
    region = "us-east-1"
  }
}

# Modulo para conexão dos peerings
module "vpc_peering" {
  source = "../../../../modules/vpc/modules/vpc_peering_requester"
  peer_owner_id = "554786642939"
  peer_region = "sa-east-1"
  vpc_accepter_id = "vpc-058181bb71c447a2f"
  destination_network = "10.100.0.0/16"
  tags = {
    Name = "geru-prod-sa"
  }
}