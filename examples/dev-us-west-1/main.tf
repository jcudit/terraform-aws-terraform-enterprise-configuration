module "configuration" {
  source = "../../"

  organization_name = var.organization_name
  environment       = var.environment
  region            = var.region
  hostname          = var.hostname
}
