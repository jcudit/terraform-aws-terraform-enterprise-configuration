output "team_names" {
  description = "A list of team names managed by this module"
  value       = [for team in tfe_team.managed_teams : team.name]
}
