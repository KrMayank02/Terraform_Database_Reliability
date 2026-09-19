# variables.tf

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "db_password" {
  type        = string
  description = "Databas Password"
  sensitive   = true
  ## value Passed in Environment Variables ##
}
