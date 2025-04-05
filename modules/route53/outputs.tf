output "public_zone_id" {
  description = "ID of the public hosted zone"
  value       = try(aws_route53_zone.public[0].zone_id, "")
}

output "public_zone_name_servers" {
  description = "Name servers of the public hosted zone"
  value       = try(aws_route53_zone.public[0].name_servers, [])
}

output "private_zone_id" {
  description = "ID of the private hosted zone"
  value       = try(aws_route53_zone.private[0].zone_id, "")
}

output "private_zone_name_servers" {
  description = "Name servers of the private hosted zone"
  value       = try(aws_route53_zone.private[0].name_servers, [])
} 