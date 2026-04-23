output "queue_urls" {
  description = "Mapeia nome da fila -> URL"
  value       = { for name, q in aws_sqs_queue.queues : name => q.url }
}

output "queue_arns" {
  description = "Mapeia nome da fila -> ARN"
  value       = { for name, q in aws_sqs_queue.queues : name => q.arn }
}
