output "cluster_id" {
  value       = aws_ecs_cluster.default.id
  description = "The ECS cluster ID"
}
