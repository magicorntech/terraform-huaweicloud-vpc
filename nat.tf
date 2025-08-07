##### Create NAT Gateway
resource "huaweicloud_nat_gateway" "main" {
  count       = (var.nat_gateway == true) ? var.nat_count : 0
  name        = "${var.tenant}-${var.name}-natgw-${lookup(var.pbl_sub_count[count.index], "zone")}-${var.environment}"
  description = "Managed by Magicorn"
  spec        = "1" # Small size
  vpc_id      = huaweicloud_vpc.main.id
  subnet_id   = element(huaweicloud_vpc_subnet.main_pbl.*.id, count.index)

  tags = {
    Name        = "${var.tenant}-${var.name}-natgw-${lookup(var.pbl_sub_count[count.index], "zone")}-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

##### Create SNAT Rules
resource "huaweicloud_nat_snat_rule" "main_pvt" {
  count          = length(var.pvt_sub_count) > 0 && var.nat_gateway == true ? length(var.pvt_sub_count) : 0
  nat_gateway_id = element(huaweicloud_nat_gateway.main.*.id, count.index % var.nat_count)
  subnet_id      = element(huaweicloud_vpc_subnet.main_pvt.*.id, count.index)
  floating_ip_id = element(huaweicloud_vpc_eip.nat.*.id, count.index % var.nat_count)
}

resource "huaweicloud_nat_snat_rule" "main_cce" {
  count          = length(var.cce_sub_count) > 0 && var.nat_gateway == true ? length(var.cce_sub_count) : 0
  nat_gateway_id = element(huaweicloud_nat_gateway.main.*.id, count.index % var.nat_count)
  subnet_id      = element(huaweicloud_vpc_subnet.main_cce.*.id, count.index)
  floating_ip_id = element(huaweicloud_vpc_eip.nat.*.id, count.index % var.nat_count)
}

##### Create EIP for NAT Gateway
resource "huaweicloud_vpc_eip" "nat" {
  count      = var.nat_gateway == true ? var.nat_count : 0
  
  publicip {
    type = "5_bgp"
  }

  bandwidth {
    name        = "${var.tenant}-${var.name}-nat-eip-${lookup(var.pbl_sub_count[count.index], "zone")}-${var.environment}"
    size        = var.nat_bandwidth
    share_type  = "PER"
    charge_mode = "traffic"
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-nat-eip-${lookup(var.pbl_sub_count[count.index], "zone")}-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}