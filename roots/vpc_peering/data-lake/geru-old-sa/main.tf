provider "aws" {
  region = "us-east-1"
}

# Local onde é armazenado o state do terraform
terraform {
  backend "s3" {
    bucket = "terraform-geru"
    key    = "state/data-lake/vpc_peering/geru-old-sa/terraform.tfstate"
    region = "us-east-1"
  }
}

# Modulo para conexão dos peerings
module "vpc_peering" {
  source = "../../../../modules/vpc/modules/vpc_peering_requester"
  peer_owner_id = "232667596449"
  peer_region = "sa-east-1"
  vpc_accepter_id = "vpc-2a64ed4f"
  destination_network = "172.31.0.0/16"
  tags = {
    Name = "geru-old-sa"
  }
}