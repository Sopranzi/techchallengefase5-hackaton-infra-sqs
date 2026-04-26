# Outputs existentes
output "queue_urls" {
  description = "Mapeia nome da fila -> URL"
  value       = { for name, q in aws_sqs_queue.queues : name => q.url }
}

output "queue_arns" {
  description = "Mapeia nome da fila -> ARN"
  value       = { for name, q in aws_sqs_queue.queues : name => q.arn }
}

# Novos outputs para as DLQs
output "dlq_urls" {
  description = "Mapeia nome da DLQ -> URL"
  value       = { for name, q in aws_sqs_queue.dlqs : name => q.url }
}

output "dlq_arns" {
  description = "Mapeia nome da DLQ -> ARN"
  value       = { for name, q in aws_sqs_queue.dlqs : name => q.arn }
}