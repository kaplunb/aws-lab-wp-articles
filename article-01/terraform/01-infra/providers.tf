terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    key     = "terraform.tfstate"
    encrypt = true
  }

  required_version = ">= 1.7.0"
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = "dev"
      Project     = "AWS WprdPress lab"
      ManagedBy   = "terraform"
    }
  }
}