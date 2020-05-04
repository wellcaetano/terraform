resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = "${var.peering_connection_id}"
  auto_accept = true
/*  tags {
    Side = "Accepter"
    Name = "${var.peer_name}"
  }
*/  
}

resource "aws_security_group_rule" "allow_vpc_peering" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["${var.destination_network}"]

  security_group_id = "${var.security_group_id}"

}

resource "aws_route" "private" {
  route_table_id = "${var.private_route_table_id}"
  destination_cidr_block = "${var.destination_network}"
  vpc_peering_connection_id = "${var.peering_connection_id}"
}

/*resource "aws_route" "public" {
  route_table_id = "${var.public_route_table_id}"
  destination_cidr_block = "${var.destination_network}"
  vpc_peering_connection_id = "${var.peering_connection_id}"
}
