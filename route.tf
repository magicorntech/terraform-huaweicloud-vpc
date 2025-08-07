##### Create Route Tables
resource "huaweicloud_vpc_route_table" "main_pbl" {
  name        = "${var.tenant}-${var.name}-pbl-route-${var.environment}"
  vpc_id      = huaweicloud_vpc.main.id
  description = "Public Route Table Managed by Magicorn"
  subnets     = huaweicloud_vpc_subnet.main_pbl.*.id
}

resource "huaweicloud_vpc_route_table" "main_pvt" {
  count       = (length(var.pvt_sub_count) > 0) ? var.nat_count : 0
  name        = "${var.tenant}-${var.name}-pvt-route-${var.environment}"
  vpc_id      = huaweicloud_vpc.main.id
  description = "Private Route Table Managed by Magicorn"
  subnets     = (var.nat_count > 1) ? [element(huaweicloud_vpc_subnet.main_pvt.*.id, count.index)] : huaweicloud_vpc_subnet.main_pvt.*.id
}

resource "huaweicloud_vpc_route_table" "main_cce" {
  count       = (length(var.cce_sub_count) > 0) ? var.nat_count : 0
  name        = "${var.tenant}-${var.name}-cce-route-${var.environment}"
  vpc_id      = huaweicloud_vpc.main.id
  description = "CCE Route Table Managed by Magicorn"
  subnets     = (var.nat_count > 1) ? [element(huaweicloud_vpc_subnet.main_cce.*.id, count.index)] : huaweicloud_vpc_subnet.main_cce.*.id
}

resource "huaweicloud_vpc_route_table" "main_db" {
  count       = (length(var.db_sub_count) > 0) ? 1 : 0
  name        = "${var.tenant}-${var.name}-db-route-${var.environment}"
  vpc_id      = huaweicloud_vpc.main.id
  description = "Database Route Table Managed by Magicorn"
  subnets     = huaweicloud_vpc_subnet.main_db.*.id
}

resource "huaweicloud_vpc_route" "main_pvt_route" {
  count          = (length(var.pvt_sub_count) > 0 && var.nat_gateway == true) ? var.nat_count : 0
  vpc_id         = huaweicloud_vpc.main.id
  destination    = "0.0.0.0/0"
  type           = "nat"
  nexthop        = element(huaweicloud_nat_gateway.main.*.id, count.index)
  route_table_id = element(huaweicloud_vpc_route_table.main_pvt.*.id, count.index)
}

resource "huaweicloud_vpc_route" "main_cce_route" {
  count          = (length(var.cce_sub_count) > 0 && var.nat_gateway == true) ? var.nat_count : 0
  vpc_id         = huaweicloud_vpc.main.id
  destination    = "0.0.0.0/0"
  type           = "nat"
  nexthop        = element(huaweicloud_nat_gateway.main.*.id, count.index)
  route_table_id = element(huaweicloud_vpc_route_table.main_cce.*.id, count.index)
}