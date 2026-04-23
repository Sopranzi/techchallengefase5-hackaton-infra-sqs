variable "aws_region" {
  type        = string
  description = "AWS region where queues will be created"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Project prefix for naming"
  default     = "techchallenge-fase5"
}

variable "queue_names" {
  description = "List of SQS queue names to create"
  type        = list(string)
  default = [
    "requested-analysis",
    "requested-report"
  ]
}

variable "queue_configuration" {
  description = "Optional overrides applied to both queues"
  type = object({
    visibility_timeout_seconds = optional(number, 30)
    message_retention_seconds  = optional(number, 345600) # 4 dias
    max_message_size           = optional(number, 262144)
    delay_seconds              = optional(number, 0)
    receive_wait_time_seconds  = optional(number, 0)
  })
  default = {}
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Project   = "TechChallenge-Fase5"
  }
}
