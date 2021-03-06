# Parameters

## Inputs

| Parameter | Default value | Description | Type  | Required | Example |
|-----------|---------------|-------------|-------|----------|---------|
| server | | FQDN or IP of vSphere server | String | Yes | |
| user| | vSphere username | String | Yes | |
| password | | vSphere password | String | Yes | |
| unverified_ssl | `true` | Verify SSL certificate | Bool | No | |
| datacenter | | In which datacenter the VM will be created | String | Yes | |
| cluster | | In which cluster the VM will be created | String | Yes | |
| datastore | | Datastore name used for storage | String | Yes | |
| port_group | `VM Network` | In which port group the VM NIC will be configured | String | No | |
| vm_template | | Where is the VM template located | String | Yes | |
| name | | Give a name for the VM that you want to create | String | Yes | |
| vcpu_number | `1` | How many vCPU will be assigned to the VM | Number | No | |
| num_cores_per_socket | `1` | The number of cores to distribute among the CPUs in this virtual machine | Number | No | |
| memory_size | `1024` | How much RAM memory will be assigned to the VM | Number | No | |
| domain | | The domain of the VM. This is added as the domain name on Linux, and to the DNS domain search list on both Linux and Windows | String | Yes | |
| time_zone | `UTC` | Sets the time zone | String | No | |
| ipv4_network_address | `0.0.0.0/0` | The IPv4 address assigned to this network adapter. If left blank or not included, DHCP is used | String | No | |
| ipv4_address_start | `1` | The IP address to start assigning virtual machines at, relative to the network address and mask | Number | No | For two VMs in 10.0.0.0/24, a value of 10 here would give the IP addresses 10.0.0.10 and 10.0.0.11. For 10.0.0.128/25, a value of 10 would give 10.0.0.138 and 10.0.0.139 |
| ipv4_address | | Static IPv4 address assigned to the network adapter. If left blank or not included, DHCP is used | String | No | |
| ipv4_netmask | | The IPv4 subnet mask, in bits. If left blank or not included, DHCP is used | Number | No | Example: 24 for 255.255.255.0 |
| ipv4_gateway | `0` | The IPv4 default gateway when using network_interface customization on the VM | String | Yes | |
| dns_servers | `['8.8.8.8']` | The DNS servers to assign to each VM | List | No | |
| number_of_vms | `1` | How many VM(s) you want to create | Number | No | |
| vm_type | | The vm type of the supplied template | String | Yes | bare, linux |
| wait_for_guest_net_timeout | `5` | The timeout, in mintues, to wait for the guest network when creating virtual machines. On virtual machines created from scratch, you may wish to adjust this value to -1, which will disable the waiter | Number | No | |
| disk_size | | The amount of disk space to assign to each VM. Leave blank to use the template's disk size (cloned VMs only) | Number | No | |
| linked_clone | `false` | Clone the VM from a snapshot. If selected, the VM must have a single snapshot created. Cloned VMs only | Bool | No | |
| disk_label | `disk0` |A label for the disk0 | String | No | |
| resource_pool | | The resource pool to deploy the VM(s) to. If specifying a the root resource pool of a cluster, enter resource name | String | No | If No, you need to have cluster specified |
| guest_id | | The virtual machine type. This only applies to VMs being created from scratch | String | No | |
| vmdk_type | `thin` | The type of disk to create | String | No | eagerZeroedThick, lazy, or thin |
| provisioner_user | | The user to access the server for provisioning | String | No | |
| provisioner_password | | The password to access the server for provisioning | String | No | |
| provisioner_port | `22` | The port for access the VM | Number | No | |
| provisioner_source_file | | Source script file for provisioning | String | No | |
| provisioner_destination_file | `setup.sh` | Destination script file for provisioning | String | No | |
| provisioner_remote_commands | `["sudo /bin/bash setup.sh"]` | Execute remote shell commands | List | No | |
| enable_anti_affinity_rule | `false` |  An anti-affinity rule places a group of virtual machines across different hosts, which prevents all virtual machines from failing at once in the event that a single host fails. Should be true if you want this. DRS must be enabled | Bool | No | |
| folder | | In which folder the VM will be store. Use this parameter if the folder was created before | String | No | `Infrastructure` or `Infrastructure/VMware` |
| tag_category | | Add tag category name. Use this parameter if the category was created before | String | No | |
| tags | | Add tags to vSphere resources. Use this parameter if the tags were created | List | No | |
| note | | Add note for VM | String | No | |

Gloabl configs (use this as separate terraform config files)

| Parameter | Default value | Description | Type  | Required | Example |
|-----------|---------------|-------------|-------|----------|---------|
| create_folders | | A list with folders path to store datacenter, host, cluster, vm and network. Use this if you want to create the folders | List | Yes | E.g. `["Automation", "Automation/Terraform"]`|
| folder_type | `vm` | The type of folder to create | String | No | Allowed options are datacenter for datacenter folders, host for host and cluster folders, vm for virtual machine folders, datastore for datastore folders, and network for network folders |
| category_associable_types | `["VirtualMachine", "Datastore"]` | A list object types that this category is valid to be assigned to | List | No | |
| category_cardinality | `MULTIPLE` | The number of tags that can be assigned from this category to a single object at once | String | No | SINGLE, MULTIPLE |
| category_description | `Managed by Terraform` | Set a description for the category tag | String | No | |
| create_tag_category | | A tag category name to create | String | Yes | |
| create_tags | `[]` | A list with tags name to create | List | No | |
| tags_description | `Managed by Terraform` | Set a description for the tag(s) | String | No | |
| create_custom_attributes | | Create custom attributes. For now custom attributes can manage objects only for `VirtualMachine` type | List | No | |

## Outputs

| Parameter | Description   |
|-----------|---------------|
| module.vsphere_vm.virtual_machine_names | The name of each virtual machine created |
| module.vsphere_vm.virtual_machine_ids | The ID of each virtual machine created, indexed by name |
| module.vsphere_vm.virtual_machine_default_ips | The default IP address of each virtual machine deployed, indexed by name |

Gloabl configs (use this as separate terraform config files)

| Parameter | Description   |
|-----------|---------------|
| module.vsphere_vm.folders | Show folder path name |
| module.vsphere_vm.category_name | Show tag category name |
| module.vsphere_vm.tag_name | List tag(s) name |
