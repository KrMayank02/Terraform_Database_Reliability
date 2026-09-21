# infra/envs/prod/terraform.tfvars #

aws_region  = "us-east-1"
environment = "prod"
vpc_cidr    = "10.1.0.0/16"

# Scaled sizing for prod
ecs_cpu           = 1024
ecs_memory        = 2048
ecs_desired_count = 3

# High availability RDS config
db_instance_class          = "db.r6g.large"
db_allocated_storage       = 100
db_backup_retention_period = 30
db_deletion_protection     = true
db_password                = "ProdSuperSecurePass123!"