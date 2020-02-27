# ------------------------------------------------------------------------------
# WORKSPACE
# ------------------------------------------------------------------------------

locals {
  service = "terraform-enterprise"
  suffix  = format("%s-%s-%s", var.region, var.cloud_provider, local.service)
  environments = {
    "production" : format("prd-%s", local.suffix),
    "staging" : format("stg-%s", local.suffix),
    "development" : format("dev-%s", local.suffix),
  }
}

resource "tfe_workspace" "terraform_enterprise" {

  for_each   = local.environments
  name       = each.value
  auto_apply = each.key == "production" ? false : true

  organization          = var.organization_name
  working_directory     = ".config/terraform"
  file_triggers_enabled = true

  # FIXME: Fill this in once a `oauth_token_id` is available
  # vcs_repo {
  #   identifier     = "${var.repo_org}/${local.service}"
  #   branch         = var.branch
  #   oauth_token_id = var.default_oauth_token_id
  # }

  provisioner "local-exec" {
    command = "sleep 3"
  }
}
