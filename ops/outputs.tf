output "app_url" {
  description = "Load Balancer DNS Name"
  value       = aws_alb.application_load_balancer.dns_name
}
