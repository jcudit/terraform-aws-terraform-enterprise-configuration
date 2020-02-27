# policy-aws

## Overview

This submodule supports the root module by defining AWS-specific policy.

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

This module is still a work in progress.

See [`policy-common`](../policy-common/README.md) for similar usage examples.
