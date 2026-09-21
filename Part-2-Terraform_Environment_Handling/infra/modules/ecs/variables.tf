# infra/modules/ecs/variables.tf #

variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "private_subnet_ids" { type = list(string) }
variable "alb_sg_id" { type = string }
variable "ecs_cpu" { type = number }
variable "ecs_memory" { type = number }
variable "desired_count" { type = number }
variable "db_host" { type = string }
