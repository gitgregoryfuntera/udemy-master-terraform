output "module_public_subnets" {
  value = module.vpc_cidr.public_subnets
}

output "module_private_subnets" {
  value = module.vpc_cidr.private_subnets
}

output "module_vpc_id" {
  value = module.vpc_cidr.vpc_id
}

output "module_subnets_azs" {
  value = module.vpc_cidr.azs
}
