# infra/envs/dev/backend.tf #

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  ##  backend "s3" {
  ##  bucket       = "my-company-tf-states"
  ##  key          = "dev/terraform.tfstate"
  ##  region       = "us-east-1"
  ##  use_lockfile = "true"
  #  }


}


provider "aws" {
  region = var.aws_region
}
