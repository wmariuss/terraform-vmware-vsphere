// Create global settings

variable "SERVER" {}
variable "USER" {}
variable "PASSWORD" {}

// Create folder for datacenter, host, cluster, VM and network
module "vsphere" {
  source         = "../../../"
  server         = "${var.SERVER}"
  user           = "${var.USER}"
  password       = "${var.PASSWORD}"
  unverified_ssl = true
  datacenter     = "datacenter_name"

  // Use this parameter only if the folder(s) was not created
  create_folders = ["terraform", "automation", "platforms/kubernetes"]
}
