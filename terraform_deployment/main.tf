provider "aws" {
  region  = "us-east-2"
  profile = "default"
}

module "vpc" {
  source       = "./vpc"
  vpc_cidr     = "10.0.0.0/16"
  public_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "s3" {
  source = "./s3"
}


module "alb" {
  source  = "./alb"
  vpc_id  = module.vpc.vpc_id
  subnet1 = module.vpc.subnet1
  subnet2 = module.vpc.subnet2
}

module "auto_scaling" {
  source           = "./auto_scaling"
  vpc_id           = module.vpc.vpc_id
  subnet1          = module.vpc.subnet1
  subnet2          = module.vpc.subnet2
  target_group_arn = module.alb.alb_target_group_arn
  my_public_key    = "./id_rsa.pub"
}

# module "rds" {
#   source      = "./rds"
#   db_instance = "db.t2.micro"
#   rds_subnet1 = module.vpc.private_subnet1
#   rds_subnet2 = module.vpc.private_subnet2
#   vpc_id      = module.vpc.vpc_id
# }

output "vpc" {
  value = module.vpc
}

# output "ec2" {
#   value = module.ec2
# }

output "alb" {
  value = module.alb
}
