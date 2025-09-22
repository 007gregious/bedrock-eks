terraform {
  backend "s3" {
    bucket         = "bedrock-terraform-state-sylva"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "bedrock-terraform-locks"


    endpoints = {
      s3 = "https://s3.amazonaws.com"
    }


  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
