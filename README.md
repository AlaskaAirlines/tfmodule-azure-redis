# tfmodule-azure-redis

> This project was generated by [generator-aag-terraform-module](https://github.com/AlaskaAirlines/generator-aag-terraform-module)

## Overview

Alaska Airlines Azure Redis Module
To stay up to date on our latest changes, visit our [Change Log](./docs/CHANGELOG.md).

## Usage

```hcl
module "tfmodule-azure-redis" {
  source = "github.com/AlaskaAirlines/tfmodule-azure-redis"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| actionGroupId | The ID for the action group to receive notifications of alerts | `string` | n/a | yes |
| appName | The base name of the application used in the naming convention. | `string` | n/a | yes |
| capacity | (Required) The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4. | `number` | n/a | yes |
| environment | Name of the environment ex (Dev, Test, QA, Prod) | `string` | n/a | yes |
| family | (Required) The SKU family/pricing group to use. Valid values are C (for Basic/Standard SKU family) and P (for Premium) | `string` | n/a | yes |
| firewallRules | (Optional) List of IP Addresses. | <pre>list(object({<br>    name     = string<br>    start_ip = string<br>    end_ip   = string<br>  }))</pre> | `[]` | no |
| location | (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| minimum\_tls\_version | (Optional) The minimum TLS version. Defaults to 1.2. | `string` | `"1.2"` | no |
| resource-group-name | Name of the resource group that exists in Azure | `string` | n/a | yes |
| sku\_name | (Required) The SKU of Redis to use. Possible values are Basic, Standard and Premium. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | The Route ID. |
| primary\_connection\_string | The primary connection string of the Redis Instance. |
| secondary\_connection\_string | The secondary connection string of the Redis Instance. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Development

### Prerequisites

- [terraform](https://learn.hashicorp.com/terraform/getting-started/install#installing-terraform)
- [terraform-docs](https://github.com/segmentio/terraform-docs)
- [pre-commit](https://pre-commit.com/#install)
- [golang](https://golang.org/doc/install#install)
- [golint](https://github.com/golang/lint#installation)

### Configurations

Issue the following command

```sh
> make install
```

This will perform the following steps for you

- Initialize git repository
- Install pre-commit hooks
- Install Terraform
- Prepare testing framework

### Tests

- Tests are available in `test` directory
- In the module root directory, run the below command

```sh
make test
```

## Maintainers

Author: Shadow Quests (E-Commerce Platform Team) &lt;shadowquests@alaskaair.com&gt;

> This project was generated by [generator-aag-terraform-module](https://github.com/AlaskaAirlines/generator-aag-terraform-module)
