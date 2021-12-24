variable "ecs_anywhere_config" {
  type = map(object({
    ecs_container_insights = bool
    ssm_instances          = list(string)
  }))
  description = "Configuration for the ECS Anywhere cluster"
}

variable "kms_key_id" {
  type        = string
  description = "The KMS key ID used to encrypt SSM secret data"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the cluster"
}
