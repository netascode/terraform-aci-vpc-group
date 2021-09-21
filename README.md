<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-vpc-group/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-vpc-group/actions/workflows/test.yml)

# Terraform ACI vPC Group Module

Manages ACI vPC Group

Location in GUI:
`Fabric` » `Access Policies` » `Policies` » `Switch` » `Virtual Port Channel default`

## Examples

```hcl
module "aci_vpc_group" {
  source  = "netascode/vpc-group/aci"
  version = ">= 0.0.1"

  mode = "explicit"
  groups = [{
    name     = "VPC101"
    id       = 101
    policy   = "VPC1"
    switch_1 = 101
    switch_2 = 102
  }]
}

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 0.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_mode"></a> [mode](#input\_mode) | Mode. Choices: `explicit`, `consecutive`, `reciprocal`. | `string` | `"explicit"` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | List of groups. Allowed values `id`: 1-1000. Allowed values `switch_1`: 1-16000. Allowed values `switch_2`: 1-16000. | <pre>list(object({<br>    name     = string<br>    id       = number<br>    policy   = optional(string)<br>    switch_1 = number<br>    switch_2 = number<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `fabricProtPol` object. |

## Resources

| Name | Type |
|------|------|
| [aci_rest.fabricExplicitGEp](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.fabricProtPol](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
<!-- END_TF_DOCS -->