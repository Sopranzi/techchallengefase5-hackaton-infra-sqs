locals {
  base_settings = {
    visibility_timeout_seconds = coalesce(var.queue_configuration.visibility_timeout_seconds, 30)
    message_retention_seconds  = coalesce(var.queue_configuration.message_retention_seconds, 345600)
    max_message_size           = coalesce(var.queue_configuration.max_message_size, 262144)
    delay_seconds              = coalesce(var.queue_configuration.delay_seconds, 0)
    receive_wait_time_seconds  = coalesce(var.queue_configuration.receive_wait_time_seconds, 0)
  }
}

resource "aws_sqs_queue" "queues" {
  for_each                   = toset(var.queue_names)
  name                       = each.value
  visibility_timeout_seconds = local.base_settings.visibility_timeout_seconds
  message_retention_seconds  = local.base_settings.message_retention_seconds
  max_message_size           = local.base_settings.max_message_size
  delay_seconds              = local.base_settings.delay_seconds
  receive_wait_time_seconds  = local.base_settings.receive_wait_time_seconds

  tags = merge(var.tags, {
    Name = each.value
  })
}
