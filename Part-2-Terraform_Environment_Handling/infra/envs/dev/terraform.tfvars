# infra/envs/dev/terraform.tfvars #

aws_region  = "us-east-1"
environment = "dev"
vpc_cidr    = "10.0.0.0/16"

# Low sizing for dev
ecs_cpu           = 256
ecs_memory        = 512
ecs_desired_count = 1

# Minimal RDS config
db_instance_class          = "db.t3.micro"
db_allocated_storage       = 20
db_backup_retention_period = 1
db_deletion_protection     = false
db_password                = "DevSecurePass123!"