# infra/envs/prod/main.tf #

module "network" {
  source      = "../../modules/network"
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
}

module "rds" {
  source                  = "../../modules/rds"
  environment             = var.environment
  vpc_id                  = module.network.vpc_id
  private_subnet_ids      = module.network.private_subnets
  ecs_sg_id               = module.ecs.ecs_security_group_id
  db_instance_class       = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  backup_retention_period = var.db_backup_retention_period
  deletion_protection     = var.db_deletion_protection
  db_password             = var.db_password
}

module "ecs" {
  source             = "../../modules/ecs"
  environment        = var.environment
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnets
  private_subnet_ids = module.network.private_subnets
  alb_sg_id          = module.network.alb_security_group_id
  ecs_cpu            = var.ecs_cpu
  ecs_memory         = var.ecs_memory
  desired_count      = var.ecs_desired_count
  db_host            = module.rds.db_endpoint
}