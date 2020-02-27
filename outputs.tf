output "team_names" {
  description = "A list of team names managed by this module"
  value       = module.teams.team_names
}

output "enabled_policies_common" {
  description = "A mapping of common policy names to policy descriptions"
  value       = module.policy-common.enabled_policies
}

output "workspace_ids" {
  description = "IDs of Workspaces managed by this module"
  value       = module.workspaces.workspace_ids
}
