// Create global settings
// Create categories and tags

variable "SERVER" {}
variable "USER" {}
variable "PASSWORD" {}

// Create folder for VM(s)
module "vsphere" {
  source        = "../../../"
  server        = "${var.SERVER}"
  user          = "${var.USER}"
  password      = "${var.PASSWORD}"
  unverified_ssl = true
  datacenter    = "RD"

  // Use these parameters only if the category and tags were not created
  create_tag_category = "automation"
  create_tags         = ["terraform", "platforms"]
}
