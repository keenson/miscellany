#!/usr/bin/env bash
set -e

echo "Create base terraform templates"
touch main.tf data.tf outputs.tf

if [ ! -f providers.tf ]
then
  echo "Create providers file"
  cat > providers.tf <<- PROVIDERS
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      created_by = "terraform"
    }
  }
}
PROVIDERS
fi

if [ ! -f variables.tf ]
then
  echo "Create variables file"
  cat > variables.tf <<- VARIABLES
variable "region" {
  description = "AWS region to create resources in"
  type  = string
  default = "us-east-1"
}
VARIABLES
fi

if [ ! -f locals.tf ]
then
  echo "Create locals template file"
  cat > locals.tf <<- LOCALS
locals {
}
LOCALS
fi

if [ ! -f backend.tf ]
then
  echo "Create backend template file"
  cat > backend.tf <<- BACKEND
terraform {
  backend "remote" {
    hostname = 
  }
}
BACKEND
fi

echo "Create default terraform variable file"
mkdir -p tfvars && touch tfvars/main.tfvars

echo "Create .gitignore file"
cat > .gitignore <<- IGNORE
**/.terraform/**
**/.terragrunt-cache/**
IGNORE