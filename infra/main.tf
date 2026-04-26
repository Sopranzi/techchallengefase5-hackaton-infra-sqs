locals {
  base_settings = {
    visibility_timeout_seconds = coalesce(var.queue_configuration.visibility_timeout_seconds, 30)
    message_retention_seconds  = coalesce(var.queue_configuration.message_retention_seconds, 345600)
    max_message_size           = coalesce(var.queue_configuration.max_message_size, 262144)
    delay_seconds              = coalesce(var.queue_configuration.delay_seconds, 0)
    receive_wait_time_seconds  = coalesce(var.queue_configuration.receive_wait_time_seconds, 0)
  }
}

# 1. Criação das Filas DLQ
resource "aws_sqs_queue" "dlqs" {
  for_each = toset(var.queue_names)
  name     = "${each.value}-dlq" # Nomeia como nome-da-fila-dlq

  # DLQs geralmente têm retenção maior (ex: 14 dias)
  message_retention_seconds = 1209600 

  tags = merge(var.tags, {
    Name = "${each.value}-dlq"
  })
}

# 2. Atualização das Filas Principais
resource "aws_sqs_queue" "queues" {
  for_each                   = toset(var.queue_names)
  name                       = each.value
  visibility_timeout_seconds = local.base_settings.visibility_timeout_seconds
  message_retention_seconds  = local.base_settings.message_retention_seconds
  max_message_size           = local.base_settings.max_message_size
  delay_seconds              = local.base_settings.delay_seconds
  receive_wait_time_seconds  = local.base_settings.receive_wait_time_seconds

  # Adiciona a política de redirecionamento para a DLQ
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlqs[each.key].arn
    maxReceiveCount     = 5 # Número de tentativas antes de mover para a DLQ
  })

  tags = merge(var.tags, {
    Name = each.value
  })
}