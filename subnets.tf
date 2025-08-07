##### Create Public Subnets
resource "huaweicloud_vpc_subnet" "main_pbl" {
  count             = length(var.pbl_sub_count)
  name              = "${var.tenant}-${var.name}-snet-pbl-${lookup(var.pbl_sub_count[count.index], "zone")}-${var.environment}"
  cidr              = lookup(var.pbl_sub_count[count.index], "cidr")
  gateway_ip        = cidrhost(lookup(var.pbl_sub_count[count.index], "cidr"), 1)
  vpc_id            = huaweicloud_vpc.main.id
  availability_zone = "${var.region}${lookup(var.pbl_sub_count[count.index], "zone")}"

  tags = {
    Name        = "${var.tenant}-${var.name}-snet-pbl-${lookup(var.pbl_sub_count[count.index], "zone")}-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

##### Create Private Subnets
resource "huaweicloud_vpc_subnet" "main_pvt" {
  count             = length(var.pvt_sub_count)
  name              = "${var.tenant}-${var.name}-snet-pvt-${lookup(var.pvt_sub_count[count.index], "zone")}-${var.environment}"
  cidr              = lookup(var.pvt_sub_count[count.index], "cidr")
  gateway_ip        = cidrhost(lookup(var.pvt_sub_count[count.index], "cidr"), 1)
  vpc_id            = huaweicloud_vpc.main.id
  availability_zone = "${var.region}${lookup(var.pvt_sub_count[count.index], "zone")}"

  tags = {
    Name        = "${var.tenant}-${var.name}-snet-pvt-${lookup(var.pvt_sub_count[count.index], "zone")}-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

##### Create CCE (Kubernetes) Subnets
resource "huaweicloud_vpc_subnet" "main_cce" {
  count             = length(var.cce_sub_count)
  name              = "${var.tenant}-${var.name}-snet-cce-${lookup(var.cce_sub_count[count.index], "zone")}-${var.environment}"
  cidr              = lookup(var.cce_sub_count[count.index], "cidr")
  gateway_ip        = cidrhost(lookup(var.cce_sub_count[count.index], "cidr"), 1)
  vpc_id            = huaweicloud_vpc.main.id
  availability_zone = "${var.region}${lookup(var.cce_sub_count[count.index], "zone")}"

  tags = {
    Name        = "${var.tenant}-${var.name}-snet-cce-${lookup(var.cce_sub_count[count.index], "zone")}-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

##### Create DB Subnets
resource "huaweicloud_vpc_subnet" "main_db" {
  count             = length(var.db_sub_count)
  name              = "${var.tenant}-${var.name}-snet-db-${lookup(var.db_sub_count[count.index], "zone")}-${var.environment}"
  cidr              = lookup(var.db_sub_count[count.index], "cidr")
  gateway_ip        = cidrhost(lookup(var.db_sub_count[count.index], "cidr"), 1)
  vpc_id            = huaweicloud_vpc.main.id
  availability_zone = "${var.region}${lookup(var.db_sub_count[count.index], "zone")}"

  tags = {
    Name        = "${var.tenant}-${var.name}-snet-db-${lookup(var.db_sub_count[count.index], "zone")}-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}
