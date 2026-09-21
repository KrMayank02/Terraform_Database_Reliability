# infra/envs/prod/variables.tf #

variable "aws_region" { type = string }
variable "environment" { type = string }
variable "vpc_cidr" { type = string }
variable "ecs_cpu" { type = number }
variable "ecs_memory" { type = number }
variable "ecs_desired_count" { type = number }
variable "db_instance_class" { type = string }
variable "db_allocated_storage" { type = number }
variable "db_backup_retention_period" { type = number }
variable "db_deletion_protection" { type = bool }
variable "db_password" {
  type      = string
  sensitive = true
}
