# terraform-aws-terraform-enterprise-configuration

## Overview

This repository holds a module for AWS that provides Terraform Enterprise configuration of teams, workspaces and policy.

- Teams are defined in the [`teams`](./modules/teams) submodule
- Workspaces are defined in the [`workspaces`](./modules/workspaces) submodule
- Policy is defined in `*.sentinel` files in `policy-<provider>` subdirectories
- Policy tests are defined with `*.json` files under a `test/` directory
- Similarly, mock test data is defined with `*.sentinel` files under a `test/`directory

See [Test Folder Structure](https://docs.hashicorp.com/sentinel/writing/testing/#test-folder-structure) documentation for more on this layout.

```
.
├── README.md                               # root module
├── examples
│   ├── main.tf
│   └── stg-us-east-1
│       └── main.tf
├── main.tf
├── modules
│   ├── policy-aws
│   │   ├── README.md
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── sentinel.hcl
│   │   └── variables.tf
│   ├── ...
│   │   ├── README.md
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── sentinel.hcl
│   │   └── variables.tf
│   ├── policy-common                       # policy submodule
│   │   ├── README.md
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── sentinel.hcl
│   │   └── variables.tf
│   └── policy-gcp
│       ├── README.md
│       ├── main.tf
│       ├── outputs.tf
│       ├── sentinel.hcl
│       └── variables.tf
├── test                                    # tests for root module examples
│   └── dev_us_west_1_test.go
├── variables.tf
├── outputs.tf
└── versions.tf
```

Teams and Workspaces are also defined in submodules. See the `README.md` of each directory for more details.

Additionally, see [the official Sentinel docs](https://docs.hashicorp.com/sentinel/writing/) for guides on writing policy and the [Sentinel Overview](https://www.terraform.io/docs/cloud/sentinel/index.html) for an understanding of how Sentinel integrates with Terraform Enterprise.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| enabled\_policies | A mapping of policy name to policy description used to enable policies | `map` | <code><pre>{<br>  "validate-all-variables-have-descriptions": "variables have descriptions"<br>}<br></pre></code> | no |
| environment | The environment this policy will run within | `string` | n/a | yes |
| hostname | Hostname of a Terraform Enterprise deployment to configure | `string` | `""` | no |
| organization\_name | The name of the organization this module manages | `string` | n/a | yes |
| region | The region this policy will run within | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| enabled\_policies\_common | A mapping of common policy names to policy descriptions |
| team\_names | A list of team names managed by this module |

## Usage

```hcl

module "terraform_enterprise_configuration" {
  source            = ...
  organization_name = "org-${var.environment}"
  environment       = var.environment
  region            = var.region
}
```

Check out the [examples](../examples) for fully-working sample code that the [tests](../test) exercise.

---

This repo has the following folder structure:

* root folder: The root folder contains a single, standalone, reusable, production-grade module.
* [modules](./modules): This folder may contain supporting modules to the root module.
* [examples](./examples): This folder shows examples of different ways to configure the root module and is typically exercised by tests.
* [test](./test): Automated tests for the modules and examples.

See the [official docs](https://www.terraform.io/docs/modules/index.html) for further details.

---

This repository was initialized with an Issue Template.
[See here](https://github.com/github-terraform-staging/terraform-aws-terraform-enterprise-policy/issues/new/choose).
