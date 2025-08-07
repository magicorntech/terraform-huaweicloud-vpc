output "vpc_id" {
	value = huaweicloud_vpc.main.id
}

output "cidr_block" {
	value = huaweicloud_vpc.main.cidr
}

output "pbl_subnet_ids" {
	value = huaweicloud_vpc_subnet.main_pbl.*.id
}

output "pbl_subnet_ids_os" {
	value = huaweicloud_vpc_subnet.main_pbl.*.ipv4_subnet_id
}

output "pvt_subnet_ids" {
	value = huaweicloud_vpc_subnet.main_pvt.*.id
}

output "pvt_subnet_ids_os" {
	value = huaweicloud_vpc_subnet.main_pvt.*.ipv4_subnet_id
}

output "cce_subnet_ids" {
	value = huaweicloud_vpc_subnet.main_cce.*.id
}

output "cce_subnet_ids_os" {
	value = huaweicloud_vpc_subnet.main_cce.*.ipv4_subnet_id
}

output "db_subnet_ids" {
	value = huaweicloud_vpc_subnet.main_db.*.id
}

output "db_subnet_ids_os" {
	value = huaweicloud_vpc_subnet.main_db.*.ipv4_subnet_id
}