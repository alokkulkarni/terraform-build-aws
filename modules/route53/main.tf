resource "aws_route53_zone" "public" {
  count = var.create_public_zone ? 1 : 0

  name          = var.public_zone_name
  comment       = var.public_zone_comment
  force_destroy = var.force_destroy

  tags = merge(
    var.tags,
    {
      Name = var.public_zone_name
    }
  )
}

resource "aws_route53_zone" "private" {
  count = var.create_private_zone ? 1 : 0

  name          = var.private_zone_name
  comment       = var.private_zone_comment
  force_destroy = var.force_destroy

  vpc {
    vpc_id = var.vpc_id
  }

  tags = merge(
    var.tags,
    {
      Name = var.private_zone_name
    }
  )
}

resource "aws_route53_record" "public" {
  for_each = var.public_records

  zone_id = aws_route53_zone.public[0].zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.records
}

resource "aws_route53_record" "private" {
  for_each = var.private_records

  zone_id = aws_route53_zone.private[0].zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.records
} 