# infra/envs/prod/backend.tf #

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  ##  backend "s3" {
  ##  bucket         = "my-company-tf-states"
  ##  key            = "prod/terraform.tfstate"
  ##  region         = "us-east-1"
  ##  dynamodb_table = "terraform-locks"
  ##  }


}

provider "aws" {
  region = var.aws_region
}
