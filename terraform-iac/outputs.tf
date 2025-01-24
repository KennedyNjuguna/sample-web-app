output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "instance_public_ip" {
  value = module.ec2_instance.public_ip
}
