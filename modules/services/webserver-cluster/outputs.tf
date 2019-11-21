output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP address of the web server"
}


output "alb_dns_name" {
  value       = module.webserver_cluster.dns_name
  description = "The domain name of the load balancer"
}

output "alb_security_group_id" {
  value       = aws_security_group.alb.id
  description = "The ID of the Security Group attached to the load balancer"
}
output "asg_name" {
  value       = aws_autoscaling_group.example.name
  description = "The name of the Auto Scaling Group"
}