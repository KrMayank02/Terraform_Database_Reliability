# infra/modules/rds/variables.tf #

variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "ecs_sg_id" { type = string }
variable "db_instance_class" { type = string }
variable "allocated_storage" { type = number }
variable "backup_retention_period" { type = number }
variable "deletion_protection" { type = bool }
variable "db_password" {
  type      = string
  sensitive = true
}
