# terraform-aws-mcaf-ecs-anywhere

MCAF Terraform module to create and manage an ECS Anywhere setup on an AWS account.

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| aws | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Name of the ECS Anywhere cluster | `string` | n/a | yes |
| kms\_key\_id | The KMS key ID used to encrypt SSM secret data | `string` | n/a | yes |
| tags | A mapping of tags to assign to resources that support it | `map(string)` | n/a | yes |
| cluster\_instances | List of cluster instances that will get SSM activation entries | `list(string)` | `[]` | no |
| container\_insights | Whether or not to enable Container Insights to log to Cloudwatch Metrics | `bool` | `false` | no |
| ssm\_role\_additional\_policy\_arns | List of additional policy ARNs to attach to the SSM role | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | The ECS cluster ID |
| ssm\_role\_id | The IAM role ID used for the SSM activation |

<!--- END_TF_DOCS --->

## License

**Copyright:** Schuberg Philis

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
