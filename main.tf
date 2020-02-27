#------------------------------------------------------------------------------
# Terraform Enterprise
#------------------------------------------------------------------------------

locals {
  domain       = "fixme.com"
  env_hostname = "terraform-${var.environment}.${var.domain}"
  hostname     = var.hostname == "" ? local.env_hostname : var.hostname
}

provider "tfe" {
  hostname = local.hostname
}

#------------------------------------------------------------------------------
# Teams and Workspaces
#------------------------------------------------------------------------------

module "teams" {
  source            = "./modules/teams"
  environment       = var.environment
  organization_name = var.organization_name
}

module "workspaces" {
  source            = "./modules/workspaces"
  environment       = var.environment
  region            = var.region
  organization_name = var.organization_name
}

#------------------------------------------------------------------------------
# Common Policy
#------------------------------------------------------------------------------

module "policy-common" {
  source            = "./modules/policy-common"
  region            = var.region
  environment       = var.environment
  organization_name = var.organization_name
}

#------------------------------------------------------------------------------
# AWS Policy
#------------------------------------------------------------------------------

# module "policy-aws" {
#   source       = "./modules/policy-aws"
#   organization = var.organization
#   environment  = var.environment
#   region       = var.region
# }
