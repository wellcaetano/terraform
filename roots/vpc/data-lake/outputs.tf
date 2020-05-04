# VPC
output "vpc_id" {
  description = "O ID da VPC"
  value       = module.vpc.vpc_id
}

# Subnets
output "private_subnets" {
  description = "Lista dos IDs das subnets privadas"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Lista dos IDs das subnets publicas"
  value       = module.vpc.public_subnets
}

# NAT gateways
output "nat_public_ips" {
  description = "lista dos Elastic IPs criados para AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

# Route Tables
output "private_route_table_ids" {
  description = "Lista dos Ids das route tables privadas"
  value = module.vpc.private_route_table_ids
}

output "public_route_table_ids" {
  description = "Lista dos Ids das route tables publicas"
  value = module.vpc.public_route_table_ids
}
