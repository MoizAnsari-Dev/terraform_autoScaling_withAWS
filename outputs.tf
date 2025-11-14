output "vpc_id" {
  value = module.vpc.vpc_id
}

output "security_group_id" {
  value = module.security_group.sg_id
}

output "asg_name" {
  value = module.ec2_asg.asg_name
}
