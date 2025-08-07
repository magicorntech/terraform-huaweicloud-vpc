# terraform-huaweicloud-vpc

Magicorn made Terraform Module for Huawei Cloud Provider
--
```
module "vpc" {
  source      = "magicorntech/vpc/huaweicloud"
  version     = "0.0.1"
  tenant      = var.tenant
  name        = var.name
  environment = var.environment
  region      = var.region

  # VPC Configuration
  cidr_block    = "10.160.0.0/16"
  nat_gateway   = true
  nat_count     = 2
  nat_bandwidth = 200

  # Subnet Mapping
  pbl_sub_count = [
    { cidr = "10.160.8.0/21", zone = "a" }
  ]
  pvt_sub_count = [
    { cidr = "10.160.40.0/21", zone = "a" },
    { cidr = "10.160.48.0/21", zone = "b" }
  ]
  cce_sub_count = [
    { cidr = "10.160.112.0/20", zone = "a" },
    { cidr = "10.160.128.0/20", zone = "b" }
  ]
  db_sub_count = [
    { cidr = "10.160.72.0/21", zone = "a" }
  ]
}

```