# policy-common

## Overview

This submodule supports the root module by defining provider-agnostic policy.

- Individual policies are scripts in `*.sentinel` files located in this module's root directory
- An authorative `sentinel.hcl` configures enforcement levels of each policy
   ```hcl
   policy "validate-all-variables-have-descriptions" {
       enforcement_level = "advisory"
   }

   policy "deprecate-module-versions" {
       enforcement_level = "advisory"
   }
   ```
- Policy tests are defined with `*.json` files under the [`test/`](./test) directory
   - There is a subdirectory per policy
   - Similarly, mock test data is defined with `*.sentinel` files under a per-policy subdirectory

   ```
   .
   ├── README.md                               # policy-common submodule
   ├── deprecate-module-versions.sentinel
   ├── main.tf
   ├── outputs.tf
   ├── sentinel.hcl
   ├── test
   │   ├── deprecate-module-versions               # per-policy directory
   │   │   ├── fail-0.12.json
   │   │   ├── mock-tfconfig-fail-0.12.sentinel    # mock data (plan, state)
   │   │   ├── mock-tfconfig-pass-0.12.sentinel
   │   │   └── pass-0.12.json
   │   └── validate-all-variables-have-descriptions
   │       ├── fail-0.11.json                      # test declaration
   │       ├── fail-0.12.json
   │       ├── mock-tfconfig-fail-0.11.sentinel
   │       ├── mock-tfconfig-fail-0.12.sentinel
   │       ├── mock-tfconfig-pass-0.11.sentinel
   │       ├── mock-tfconfig-pass-0.12.sentinel
   │       ├── mock-tfplan-fail-0.11.sentinel
   │       ├── mock-tfplan-fail-0.12.sentinel
   │       ├── mock-tfplan-pass-0.11.sentinel
   │       ├── mock-tfplan-pass-0.12.sentinel
   │       ├── pass-0.11.json                      # test declaration
   │       └── pass-0.12.json
   ├── validate-all-variables-have-descriptions.sentinel
   └── variables.tf
   ```

## Usage

### Adding Additional Policies

With the goal of deprecating use of Debian 8 across all cloud infrastructure, the following steps could be taken.

1. Choose a policy name (`deprecate-debian-8` in this example)
1. Add a new test case directory (`test/deprecate-debian-8` in this example)
1. Add mock data to the test case (`test/deprecate-debian-8/*.sentinel` in this example)
1. Add test cases (`test/deprecate-debian-8/*.json` in this example)
1. Add a policy script (`deprecate-debain-8.sentinel` in this example)
1. Iterate towards passing test cases with `sentinel` (see [below](#testing-additional-policies))
1. [Configure `sentinel.hcl`](#enabling-additional-policies) with a desired enforcement level for the policy
1. Commit your changes and publish a PR for review and guidance on deployment next steps

### Testing Additional Policies

From the `policy-<provider>` directory, `sentinel` can be run to exercise tests:

```bash
$ sentinel test -run=deprecate-module-versions  -verbose
PASS - deprecate-module-versions.sentinel
 PASS - test/deprecate-module-versions/fail-0.12.json


   logs:
     Module database/aws with version v0.0.6 was found
     Module foundation-minimal/aws with version v0.0.1 was found
     Deprecated version matching ^v0.0.[321]$ found for foundation-minimal/aws
     Module terraform-enterprise-policy/aws with version 0.0.5 was found
     Module terraform-enterprise/aws with version v0.0.9 was found
   trace:
     FALSE - deprecate-module-versions.sentinel:60:1 - Rule "main"
 PASS - test/deprecate-module-versions/pass-0.12.json


   logs:
     Module database/aws with version v0.0.6 was found
     Module foundation-minimal/aws with version v0.0.4 was found
     Module terraform-enterprise-policy/aws with version 0.0.5 was found
     Module terraform-enterprise/aws with version v0.0.9 was found
   trace:
     TRUE - deprecate-module-versions.sentinel:60:1 - Rule "main"
```

### Enabling Additional Policies

Additional policies should be enabled by editing [`sentinel.hcl`](./sentinel.hcl).

### Module Usage

```hcl
module "policy-common" {
  source            = "./modules/policy-common"
  region            = var.region
  environment       = var.environment
  organization_name = var.organization_name
}
```
