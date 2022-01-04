variable "cluster_instances" {
  type        = list(string)
  default     = []
  description = "List of cluster instances that will get SSM activation entries"
}

variable "cluster_name" {
  type        = string
  description = "Name of the ECS Anywhere cluster"
}

variable "container_insights" {
  type        = bool
  default     = false
  description = "Whether or not to enable Container Insights to log to Cloudwatch Metrics"
}

variable "kms_key_id" {
  type        = string
  description = "The KMS key ID used to encrypt SSM secret data"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to resources that support it"
}
