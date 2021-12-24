locals {
  ssm_instances = flatten([
    for k, v in var.ecs_anywhere_config : [
      for instance in v.ssm_instances :
      {
        cluster_name  = k
        instance_name = instance
      }
    ]
  ])
  ssm_instances_distinct = { for instance in local.ssm_instances : "${instance.cluster_name}.${instance.instance_name}" => instance }
}

resource "aws_ecs_cluster" "default" {
  for_each = var.ecs_anywhere_config

  name = each.key
  tags = var.tags

  setting {
    name  = "containerInsights"
    value = each.value.ecs_container_insights ? "enabled" : "disabled"
  }
}

data "aws_region" "current" {}

data "aws_iam_policy_document" "default" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "default" {
  name = "ECSAnywhereSSMRole"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
  assume_role_policy = data.aws_iam_policy_document.default.json
}

resource "aws_ssm_activation" "default" {
  for_each = local.ssm_instances_distinct

  name               = each.value.instance_name
  description        = "SSM ECS Anywhere activation for ${each.value.instance_name}"
  iam_role           = aws_iam_role.default.id
  registration_limit = 5
  tags               = var.tags
}

resource "aws_ssm_parameter" "activation_code" {
  for_each = local.ssm_instances_distinct

  name        = "/ecs/${each.value.cluster_name}/activation/${each.value.instance_name}/activation_code"
  description = "SSM Activation Code for ${each.value.instance_name}"
  type        = "SecureString"
  value       = aws_ssm_activation.default[each.key].activation_code
  tags        = var.tags
}

resource "aws_ssm_parameter" "activation_id" {
  for_each = local.ssm_instances_distinct

  name        = "/ecs/${each.value.cluster_name}/activation/${each.value.instance_name}/activation_id"
  description = "SSM Activation Id for ${each.value.instance_name}"
  type        = "SecureString"
  value       = aws_ssm_activation.default[each.key].id
  tags        = var.tags
}

resource "aws_ssm_parameter" "shell_command" {
  for_each = local.ssm_instances_distinct

  name        = "/ecs/${each.value.cluster_name}/activation/${each.value.instance_name}/shell_command"
  description = "SSM Activation Id for ${each.value.instance_name}"
  type        = "SecureString"
  value       = "curl --proto \"https\" -o \"/tmp/ecs-anywhere-install.sh\" \"https://amazon-ecs-agent.s3.amazonaws.com/ecs-anywhere-install-latest.sh\" && bash /tmp/ecs-anywhere-install.sh --region \"${data.aws_region.current.name}\" --cluster \"${each.value.cluster_name}\" --activation-id \"${aws_ssm_activation.default[each.key].id}\" --activation-code \"${aws_ssm_activation.default[each.key].activation_code}\""
  tags        = var.tags
}
