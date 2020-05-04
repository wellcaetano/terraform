variable "vpc_requester_id" {
  default = ""
}

variable "peer_region" {
  default = ""
}

variable "peer_name" {
  default = "peer"
}

variable "vpc_accepter_id" {
  default = ""
}

variable "private_route_table_id" {
  default = ""
}

variable "public_route_table_id" {
  default = ""
}

variable "destination_network" {
  default = ""
}

variable "security_group_id" {
  default = ""
}

variable "peer_owner_id" {
  default = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "allow_remote_vpc_dns_resolution" {
  default = true
}