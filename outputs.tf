output "cluster_id" {
  value       = aws_ecs_cluster.default.id
  description = "The ECS cluster ID"
}

output "ssm_role_id" {
  value       = aws_iam_role.default.id
  description = "The IAM role ID used for the SSM activation"
}
