variable "vsphere_server" {
  type = string
}
variable "vsphere_user" {
  type = string
}
variable "vsphere_password" {
  type = string
}

variable "unverified_ssl" {
  description = "Should be false if you want to enable SSL certificate verification"
  default     = true
}

variable "datacenter" {
  type        = string
  description = "In which datacenter the VM will be deployed"
  default     = ""
}

variable "esxi_host" {
  type        = string
  description = "Specify ESXi host. THis is used for create resources pool using standalone host"
  default     = ""
}

variable "cluster" {
  type        = string
  description = "In which cluster the VM will be deployed"
  default     = ""
}

variable "datastore" {
  type        = string
  description = "Datastore name for storage"
  default     = ""
}

variable "port_group" {
  type        = string
  description = "In which port group the VM NIC will be configured"
  default     = "VM Network"
}

variable "vm_template" {
  type        = string
  description = "Where is the VM template located"
  default     = ""
}

variable "name" {
  type        = string
  description = "Give a name for VM"
  default     = ""
}

variable "vcpu_number" {
  description = "How many vCPU will be assigned to the VM"
  default     = 1
}

variable "num_cores_per_socket" {
  description = "The number of cores to distribute among the CPUs in this virtual machine"
  default     = 1
}

variable "memory_size" {
  description = "How much RAM will be assigned to the VM"
  default     = 1024
}

variable "domain" {
  type        = string
  description = "The domain of the vm. This is added as the domain name on Linux, and to the DNS domain search list on both Linux and Windows"
  default     = ""
}

variable "time_zone" {
  type        = string
  description = "Sets the time zone"
  default     = "UTC"
}

variable "ipv4_network_address" {
  type        = string
  description = "The IPv4 address assigned to this network adapter. If left blank or not included, DHCP is used"
  default     = "0.0.0.0/0"
}

variable "ipv4_address_start" {
  description = "The IP address to start assigning virtual machines at, relative to the network address and mask. Example: for two virtual machines in 10.0.0.0/24, a value of 10 here would give the IP addresses 10.0.0.10 and 10.0.0.11. For 10.0.0.128/25, a value of 10 would give 10.0.0.138 and 10.0.0.139."
  default     = 1
}

variable "ipv4_address" {
  type        = string
  description = "Give a static IP address"
  default     = ""
}

variable "ipv4_netmask" {
  description = "The IPv4 subnet mask, in bits (example: 24 for 255.255.255.0)"
  default     = 0
}

variable "ipv4_gateway" {
  type        = string
  description = "The IPv4 default gateway when using network_interface customization on the VM"
  default     = ""
}

variable "dns_servers" {
  type        = list
  description = "The DNS servers to assign to each virtual machine"
  default     = ["8.8.8.8"]
}

variable "number_of_vms" {
  description = "Set a number to create VMs"
  default     = 1
}

variable "vm_type" {
  type        = string
  description = "VM type of the supplied template. Should be one of them: bare or linux"
  default     = ""
}

variable "wait_for_guest_net_timeout" {
  description = "The timeout, in mintues, to wait for the guest network when creating virtual machines. On virtual machines created from scratch, you may wish to adjust this value to -1, which will disable the waiter"
  default     = 5
}

variable "disk_size" {
  type        = string
  description = "The amount of disk space to assign to each VM. Leave blank to use the template's disk size (cloned VMs only)"
  default     = ""
}

variable "linked_clone" {
  description = "Clone the VM from a snapshot. If selected, the VM must have a single snapshot created. Cloned VMs only."
  default     = false
}

variable "disk_label" {
  type        = string
  description = "A label for the disk"
  default     = "disk0"
}

variable "resource_pool" {
  type        = string
  description = "The resource pool to deploy the VM(s) to. If specifying a the root resource pool of a cluster, enter resource name"
  default     = ""
}

variable "create_resource_pool" {
  type        = bool
  description = "Create resource pool"
  default     = false
}

variable "guest_id" {
  type        = string
  description = "The virtual machine type. This only applies to VMs being created from scratch"
  default     = ""
}

// Additional disks
variable "vmdk_path_list" {
  type        = map
  description = "Map with path, including filename, of the virtual disk to be created. This needs to end in .vmdk"
  default     = {}
}

variable "vmdk_type" {
  type        = string
  description = "The type of disk to create. Can be one of eagerZeroedThick, lazy, or thin"
  default     = "thin"
}

// Provisioning
variable "provisioner_user" {
  type        = string
  description = "The user to access the server"
  default     = ""
}

variable "provisioner_password" {
  type        = string
  description = "The password to access the server"
  default     = ""
}

variable "provisioner_port" {
  description = "The port for access the VM"
  default     = 22
}

variable "provisioner_source_file" {
  type        = string
  description = "Source script file for provisioning"
  default     = ""
}

variable "provisioner_destination_file" {
  type        = string
  description = "Destination script file for provisioning"
  default     = "setup.sh"
}

variable "provisioner_remote_commands" {
  type        = list
  description = "Run remote shell commands"
  default     = [
    "sudo /bin/bash setup.sh"
  ]
}

variable "enable_anti_affinity_rule" {
  description = "An anti-affinity rule places a group of virtual machines across different hosts, which prevents all virtual machines from failing at once in the event that a single host fails. Should be true if you want this. DRS must be enabled"
  default     = false
}

// For globals
// Folders
variable "folder" {
  type        = string
  description = "In which folder the VM will be store. Use this if the folder was created before"
  default     = ""
}

variable "create_folders" {
  type        = list
  description = "List with folders path to store datacenter, host, cluster, vm and network. Use this if you want to create the folders"
  default     = []
}

variable "folder_type" {
  type        = string
  description = "The type of folder to create. Allowed options are datacenter for datacenter folders, host for host and cluster folders, vm for virtual machine folders, datastore for datastore folders, and network for network folders"
  default     = "vm"
}

// Categories and tags
// Category
variable "tag_category" {
  type        = string
  description = "Tag category name"
  default     = ""
}

variable "category_associable_types" {
  type        = list
  description = "A list object types that this category is valid to be assigned to"
  default     = [
    "VirtualMachine",
    "Datastore",
  ]
}

variable "category_cardinality" {
  type        = string
  description = "The number of tags that can be assigned from this category to a single object at once. Can be one of SINGLE to MULTIPLE"
  default     = "MULTIPLE"
}

variable "category_description" {
  type    = string
  default = "Managed by Terraform"
}

variable "create_tag_category" {
  type        = string
  description = "A tag category name to create"
  default     = ""
}

// Tags
variable "tags" {
  type        = list
  description = "A list with tags name to attach"
  default     = []
}

variable "create_tags" {
  type        = list
  description = "A list with tags name to create"
  default     = []
}

variable "tags_description" {
  type    = string
  default = "Managed by Terraform"
}

variable "note" {
  type        = string
  description = "Add note to VM"
  default     = ""
}

variable "create_custom_attributes" {
  type        = list
  description = "Add custom atributes for VM(s)"
  default     = []
}

variable "add_custom_attributes" {
  type        = map
  description = "Add custom attributes already created or those exists in vSphere"
  default     = {}
}
