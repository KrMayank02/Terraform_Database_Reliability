output "alb_dns_name" {
  description = "Public URL of ALB - Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "rds_endpoint" {
  description = "Private address of the RDS MySQL Instance"
  value       = aws_db_instance.db.endpoint
}
