#!/bin/bash

echo "Development Environment Configuration"
echo "==================================="
echo

# Check if terraform.tfvars exists, if not create it from template
if [ ! -f terraform.tfvars ]; then
  echo "Creating terraform.tfvars from template..."
  cp terraform.tfvars.template terraform.tfvars
fi

echo "Please choose the number of availability zones for your development environment:"
echo "1) Single AZ (default, cost-optimized)"
echo "2) Two AZs (better availability, higher cost)"
echo
read -p "Enter your choice (1 or 2): " az_choice

case $az_choice in
  1)
    echo "Configuring for single AZ deployment..."
    sed -i '' 's/az_count.*/az_count     = 1/' terraform.tfvars
    ;;
  2)
    echo "Configuring for two AZ deployment..."
    sed -i '' 's/az_count.*/az_count     = 2/' terraform.tfvars
    ;;
  *)
    echo "Invalid choice. Using default single AZ configuration."
    sed -i '' 's/az_count.*/az_count     = 1/' terraform.tfvars
    ;;
esac

echo
echo "Configuration complete. Please update the following variables in terraform.tfvars:"
echo "- db_password: Your database password"
echo "- api_key: Your API key"
echo "- kms_key_id: Your KMS key ARN"
echo
echo "After updating the variables, you can run:"
echo "terraform init"
echo "terraform plan"
echo "terraform apply" 