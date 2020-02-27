output "team_names" {
  description = "A list of team names managed by this module"
  value       = module.configuration.team_names
}

output "enabled_policies_common" {
  description = "A mapping of common policy names to policy descriptions"
  value       = module.configuration.enabled_policies_common
}

output "workspace_ids" {
  description = "IDs of Workspaces managed by this module"
  value       = module.configuration.workspace_ids
}
