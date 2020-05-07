# Uso do remote-state do modulo VPC
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-geru"
    key    = "state/data-lake/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

# Variáveis para conexão do peering
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = data.terraform_remote_state.vpc.outputs.vpc_id
  peer_vpc_id   = "${var.vpc_accepter_id}"
  peer_owner_id = "${var.peer_owner_id}"
  peer_region   = "${var.peer_region}"
  auto_accept   = false
  tags = "${var.tags}"
  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

# Configuração de roteamento
resource "aws_route" "private" {
  route_table_id            = data.terraform_remote_state.vpc.outputs.private_route_table_ids[0]
  destination_cidr_block    = "${var.destination_network}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
}

/*resource "aws_route" "public" {
  route_table_id            = "${var.public_route_table_id}"
  destination_cidr_block    = "${var.destination_network}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
}*/