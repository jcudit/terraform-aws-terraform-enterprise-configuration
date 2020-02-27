# ------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY
# AWS_DEFAULT_REGION

# TFE_TOKEN

# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "environment" {
  description = "Terraform Enterprise environment this module configures"
  type        = string
}

variable "organization_name" {
  description = "The name of the organization this module manages"
  type        = string
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "team_names" {
  description = "The list of teams declaratively managed by this module"

  # Add a team to this file to create it in Terraform Enterprise
  default = [
    "team_a",
    "team_b",
  ]
}
