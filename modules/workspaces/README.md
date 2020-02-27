# workspaces

## Overview

This is a helper module that manages the lifecycle of Terraform Enterprise Workspaces. Configuration of Workspace variables and access can occur outside of this repository within a service's repository.

## Providers

| Name | Version |
|------|---------|
| tfe | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cloud\_provider | Cloud provider (aws, azurerm, google) | `string` | `"aws"` | no |
| environment | The environment this module will run in | `string` | n/a | yes |
| organization\_name | The Terraform Enterprise Organization this module will modify | `string` | n/a | yes |
| region | The region this module will run in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| workspace\_ids | IDs of Workspaces managed by this module |
