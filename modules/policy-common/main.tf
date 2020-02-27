resource "tfe_sentinel_policy" "policies" {
  for_each = var.enabled_policies

  description  = "Enforces ${each.value}"
  name         = each.key
  organization = var.organization_name
  policy       = file("${path.module}/${each.key}.sentinel")
  enforce_mode = "advisory"
}

resource "tfe_policy_set" "global" {
  name         = "global"
  description  = "A global policy set"
  organization = var.organization_name
  policy_ids   = [for policy in tfe_sentinel_policy.policies : policy.id]
  global       = true
}
