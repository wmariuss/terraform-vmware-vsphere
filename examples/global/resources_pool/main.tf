// Create resource pool

variable "SERVER" {}
variable "USER" {}
variable "PASSWORD" {}

// Create resource pool
module "vsphere" {
  source               = "../../../"
  server               = "${var.SERVER}"
  user                 = "${var.USER}"
  password             = "${var.PASSWORD}"
  unverified_ssl        = true
  datacenter           = "RD"
  esxi_host            = "esxi.hostname.int"
  create_resource_pool = true
  resource_pool        = "terraform"
  tags                 = ["terraform"]
}
