resource "tfe_team" "managed_teams" {
  count        = length(var.team_names)
  name         = var.team_names[count.index]
  organization = var.organization_name
}
