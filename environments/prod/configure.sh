#!/bin/bash

echo "Production Environment Configuration"
echo "=================================="
echo

# Check if terraform.tfvars exists, if not create it from template
if [ ! -f terraform.tfvars ]; then
  echo "Creating terraform.tfvars from template..."
  cp terraform.tfvars.template terraform.tfvars
fi

# Default components (always included)
DEFAULT_COMPONENTS=("vpc" "alb" "route53" "certificate" "secrets-store")

# Available components for selection
COMPUTE_COMPONENTS=("eks" "lambda")
DATABASE_COMPONENTS=("rds" "dynamodb")
STORAGE_COMPONENTS=("s3" "efs")
AI_COMPONENTS=("bedrock")

# Function to prompt for component selection
select_components() {
  local category=$1
  local components=("${!2}")
  local selected=()

  echo
  echo "Select $category components (space to select, enter to confirm):"
  for component in "${components[@]}"; do
    read -p "Include $component? (y/n) [n]: " choice
    if [[ $choice == "y" ]]; then
      selected+=("$component")
    fi
  done
  echo "${selected[@]}"
}

# Select compute components
echo "Compute Components:"
COMPUTE_SELECTED=($(select_components "compute" COMPUTE_COMPONENTS[@]))

# Select database components
echo "Database Components:"
DB_SELECTED=($(select_components "database" DATABASE_COMPONENTS[@]))

# Select storage components
echo "Storage Components:"
STORAGE_SELECTED=($(select_components "storage" STORAGE_COMPONENTS[@]))

# Select AI components
echo "AI Components:"
AI_SELECTED=($(select_components "AI" AI_COMPONENTS[@]))

# Combine all selected components
ALL_SELECTED=("${DEFAULT_COMPONENTS[@]}" "${COMPUTE_SELECTED[@]}" "${DB_SELECTED[@]}" "${STORAGE_SELECTED[@]}" "${AI_SELECTED[@]}")

# Update terraform.tfvars with selected components
echo "enabled_components = [" > terraform.tfvars.tmp
for component in "${ALL_SELECTED[@]}"; do
  echo "  \"$component\"," >> terraform.tfvars.tmp
done
echo "]" >> terraform.tfvars.tmp

# Append existing variables
grep -v "enabled_components" terraform.tfvars >> terraform.tfvars.tmp
mv terraform.tfvars.tmp terraform.tfvars

echo
echo "Configuration complete. Selected components:"
echo "Default components: ${DEFAULT_COMPONENTS[@]}"
echo "Compute components: ${COMPUTE_SELECTED[@]}"
echo "Database components: ${DB_SELECTED[@]}"
echo "Storage components: ${STORAGE_SELECTED[@]}"
echo "AI components: ${AI_SELECTED[@]}"
echo
echo "Please update the following variables in terraform.tfvars:"
echo "- project_name: Your project name"
echo "- environment: prod"
echo "- db_password: Your database password (if RDS selected)"
echo "- api_key: Your API key (if needed)"
echo "- kms_key_id: Your KMS key ARN"
echo "- certificate_domain: Your production domain"
echo
echo "After updating the variables, you can run:"
echo "terraform init"
echo "terraform plan"
echo "terraform apply" 