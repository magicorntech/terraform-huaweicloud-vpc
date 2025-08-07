##### Create VPC
resource "huaweicloud_vpc" "main" {
  name        = "${var.tenant}-${var.name}-vpc-${var.environment}"
  cidr        = var.cidr_block
  description = "Managed by Magicorn"

  tags = {
    Name        = "${var.tenant}-${var.name}-vpc-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}