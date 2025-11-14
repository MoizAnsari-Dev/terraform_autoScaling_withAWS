module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.vpc_cidr
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "ec2_asg" {
  source             = "./modules/ec2_asg"
  vpc_id             = module.vpc.vpc_id
  subnet_id          = module.vpc.public_subnet_id
  security_group_id  = module.security_group.sg_id
  ami                = var.ami
  instance_type      = var.instance_type
  key_name           = var.key_name
}
