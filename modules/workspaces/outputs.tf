output "workspace_ids" {
  description = "IDs of Workspaces managed by this module"
  value       = [for environment, value in tfe_workspace.terraform_enterprise : value.id]
}
