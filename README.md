# terraform-aws-mcaf-ecs-anywhere

MCAF Terraform module to create and manage an ECS Anywhere setup on an AWS account.

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.70.0 |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws_region | The AWS region these resources will reside in | string | eu-central-1 | yes |
| ecs_cluster_config | Configuration defining the clusters and their related settings and instances/hardware | map of objects | n/a | yes |
| kms_key_id | The KMS key ID used to encrypt sensitive values in the parameter store | string | n/a | yes |
| tags | Tags that will be attached to AWS resources that support it | map of strings | {} | no |


## Outputs

| Name | Description |
|------|-------------|


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
