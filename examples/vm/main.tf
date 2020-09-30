# Example create VM Linux in vSphere

# Required for call vSphere API
variable "VSPHERE_HOST" {}
variable "VSPHERE_USER" {}
variable "VSPHERE_PASSWORD" {}
# For provisioning
variable "PROVISIONER_USER" {}
variable "PROVISIONER_PASSWORD" {}

module "vsphere" {
  source           = "../../"
  vsphere_server   = var.VSPHERE_HOST
  vsphere_user     = var.VSPHERE_USER
  vsphere_password = var.VSPHERE_PASSWORD

  number_of_vms = 2

  vm_type = "linux"
  name    = "terraform-vm-test"

  memory_size   = 2048
  vcpu_number   = 2
  disk_size     = 50
  datacenter    = "RD"
  datastore     = "datastore_name"
  vm_template   = "template_name"
  domain        = "lab.hostname.net"
  resource_pool = "Test"

  // Auto generate IPv4
  # ipv4_network_address = "10.236.42.128/25"
  # ipv4_address_start   = -99

  // Give a static IPv4
  # ipv4_address         = "10.236.42.157"
  # ipv4_netmask         = 25

  port_group   = "network_name"
  linked_clone = true
  # Provisioning
  provisioner_user             = var.PROVISIONER_USER
  provisioner_password         = var.PROVISIONER_PASSWORD
  provisioner_source_file      = "../files/setup.sh"
  provisioner_destination_file = "setup.sh"
  provisioner_remote_commands = [
    "chmod 755 setup.sh",
    "./setup.sh"
  ]

  // Anti-affinity rule
  enable_anti_affinity_rule = false

  // Use this parameter if the folder was created before (global configs) or it's already created (manual)
  folder = "folder_name"

  // Use these parameters if the category and tags are already created
  tag_category = "Purpose"
  tags         = ["terraform"]
  note         = "This is for test purpose"
}
