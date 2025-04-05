resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
}

resource "aws_organizations_account" "account" {
  name      = var.account_name
  email     = var.account_email
  role_name = "OrganizationAccountAccessRole"
}

resource "aws_controltower_landing_zone" "landing_zone" {
  version = "3.0"
  manifest_json = jsonencode({
    landing_zone = {
      name = "default"
    }
  })
}

resource "aws_controltower_control" "controls" {
  for_each = var.control_tower_controls

  target_identifier = aws_organizations_account.account.id
  control_identifier = each.value
} 