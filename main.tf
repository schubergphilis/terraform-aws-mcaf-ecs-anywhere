resource "aws_ecs_cluster" "default" {
  name = var.cluster_name
  tags = var.tags

  setting {
    name  = "containerInsights"
    value = var.container_insights ? "enabled" : "disabled"
  }
}

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
  name               = "ECSAnywhereSSMRole"
  assume_role_policy = data.aws_iam_policy_document.default.json

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
}

resource "aws_ssm_activation" "default" {
  for_each = toset(var.cluster_instances)

  name               = each.value
  description        = "SSM ECS Anywhere activation for ${each.value} in cluster ${var.cluster_name}"
  iam_role           = aws_iam_role.default.id
  registration_limit = 5
  tags               = var.tags
}

resource "aws_ssm_parameter" "activation_code" {
  for_each = toset(var.cluster_instances)

  name        = "/ecs/activation/${each.value}/activation_code"
  description = "SSM Activation Code for ${each.value}"
  type        = "SecureString"
  value       = aws_ssm_activation.default[each.key].activation_code
  tags        = var.tags
}

resource "aws_ssm_parameter" "activation_id" {
  for_each = toset(var.cluster_instances)

  name        = "/ecs/activation/${each.value}/activation_id"
  description = "SSM Activation ID for ${each.value}"
  type        = "SecureString"
  value       = aws_ssm_activation.default[each.key].id
  tags        = var.tags
}
