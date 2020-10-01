# Examples

Example creating VM, folder, categories and tags.

```hcl
# Example secret.tfvars file

VSPHERE_HOST=""
VSPHERE_USER=""
VSPHERE_PASSWORD=""
PROVISIONER_USER=""
PROVISIONER_PASSWORD=""


# Example main.tf file

variable "VSPHERE_HOST" {}
variable "VSPHERE_USER" {}
variable "VSPHERE_PASSWORD" {}


module "vsphere_vm" {
  source        = "git::https://github.com/wmariuss/terraform-vmware-vsphere.git?ref=v1.0.0"
  number_of_vms = 1
  server        = "${var.VSPHERE_HOST}"
  user          = "${var.VSPHERE_USER}"
  password      = "${var.VSPHERE_PASSWORD}"

  unverified_ssl = true
  memory_size   = 2048
  vcpu_number   = 2

  vm_type     = "linux"
  name        = "test-vm-terraform"
  datacenter  = "RD"
  datastore   = "<DATASTORE_NAME>"
  vm_template = "<VM_TEMPLATE>"
  domain      = "<DOMAIN>"

  resource_pool = "<RESOURCE_POOL_NAME>"

  // Use this for auto generate IPv4
  ipv4_network_address = "10.236.42.128/25"
  ipv4_address_start   = -99

  // Use this for static IPv4
  ipv4_address         = "10.236.42.157"
  ipv4_netmask         = 25

  ipv4_gateway         = "10.236.42.129"
  port_group           = "<PORT_GROUP>
  linked_clone         = true
  dns_servers          = ["10.236.32.13", "10.236.32.14", "10.236.32.15"]

  // Provisioning
  provisioner_user       = "ubuntu"
  provisioner_password   = "ertydfgh"
  provisioner_source_file = "files/setup.sh"

  // Use this paramter only the folder is already created
  folder = "terraform"

  // Use these parameters if the category and tags are already created
  tag_category = "automation"
  tags         = ["terraform"]
}

# Example output.tf file

output "virtual_machine_names" {
  value = "${module.vsphere_vm.virtual_machine_names}"
}

output "virtual_machine_ids" {
  value = "${module.vsphere_vm.virtual_machine_ids}"
}

output "virtual_machine_default_ips" {
  value = "${module.vsphere_vm.virtual_machine_default_ips}"
}
```

```hcl
# Example creating category and tags
# Example secret.tfvars file

VSPHERE_HOST=""
VSPHERE_USER=""
VSPHERE_PASSWORD=""
PROVISIONER_USER=""
PROVISIONER_PASSWORD=""

# Example main.tf file

variable "VSPHERE_HOST" {}
variable "VSPHERE_USER" {}
variable "VSPHERE_PASSWORD" {}


module "vsphere_vm" {
  source    = "git::https://github.com/wmariuss/terraform-vmware-vsphere.git?ref=v1.0.0"
  server    = "${var.VSPHERE_HOST}"
  user      = "${var.VSPHERE_USER}"
  password  = "${var.VSPHERE_PASSWORD}"

  // Use these parameters only if the category and tags were not created
  create_tag_category = "automation"
  create_tags         = ["terraform", "testing"]
}

# Example output.tf

output "category_name" {
  value = "${module.vsphere_vm.category_name}"
}

output "tag_name" {
  value = "${module.vsphere_vm.tag_name}"
}
```

```hcl
# Example creating folders

# secret.tfvars file

VSPHERE_HOST=""
VSPHERE_USER=""
VSPHERE_PASSWORD=""
PROVISIONER_USER=""
PROVISIONER_PASSWORD=""

# Example main.tf file

variable "VSPHERE_HOST" {}
variable "VSPHERE_USER" {}
variable "VSPHERE_PASSWORD" {}

module "vsphere_vm" {
  source = "git::https://github.com/wmariuss/terraform-vmware-vsphere.git?ref=v1.0.0"

  server               = "${var.VSPHERE_HOST}"
  user                 = "${var.VSPHERE_USER}"
  password             = "${var.VSPHERE_PASSWORD}"

  datacenter       = "RD" # Required to create the folders
  // Use this parameter only the folder(s) was not created
  create_folders = ["terraform", "automation", "automation/VMware"]
}

# Example output.tf file

output "folders" {
  value = "${module.vsphere_vm.folders}"
}
```

More examples [here](../examples/).
