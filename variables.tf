# ------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ------------------------------------------------------------------------------

# TFE_TOKEN: A user token with privileges to create Organizations
# TFE_HOSTNAME: A hostname for a Terraforme Enterprise deployment to configure

# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "environment" {
  description = "The environment this policy will run within"
  type        = string
}

variable "region" {
  description = "The region this policy will run within"
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

variable "enabled_policies" {
  description = "A mapping of policy name to policy description used to enable policies"
  type        = map
  default = {
    "validate-all-variables-have-descriptions" : "variables have descriptions",
  }
}

variable "hostname" {
  description = "Hostname of a Terraform Enterprise deployment to configure"
  type        = string
  default     = ""
}
