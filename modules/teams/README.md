# teams

## Overview

This is a helper module that suppports the root module by configuring Terraform Enterprise Teams.

Teams are necessary for RBAC and are currently configured by appending to a list. Once a team is available, it can be granted permissions to a Workspace. This occurs within project-specific repositories.

## Providers

| Name | Version |
|------|---------|
| tfe | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| environment | Terraform Enterprise environment this module configures | `string` | n/a | yes |
| organization\_name | The name of the organization this module manages | `string` | n/a | yes |
| team\_names | The list of teams declaratively managed by this module | `list` | <pre>[<br>  "team_a",<br>  "team_b"<br>]<br></pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| team\_names | A list of team names managed by this module |

## Usage

```
module "teams" {
  source            = "./modules/teams"
  environment       = var.environment
  organization_name = var.organization_name
}
```
