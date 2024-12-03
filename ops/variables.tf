variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "db_username" {
  description = "RDS root user name"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}

variable "node_env" {
  description = "Node ENV variable"
  type        = string
}

variable "api_port" {
  description = "Enterprise API port"
  type        = number
}

variable "ecs_task_name" {
  description = "ECS task name"
  type        = string
}
