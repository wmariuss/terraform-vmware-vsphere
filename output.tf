output "virtual_machine_names" {
  description = "The names of each virtual machine deployed"

  value = ["${flatten(list(
    vsphere_virtual_machine.linux.*.name,
    vsphere_virtual_machine.bare.*.name
  ))}"]
}

output "virtual_machine_ids" {
  description = "The ID of each virtual machine deployed, indexed by name"

  value = "${zipmap(
    flatten(list(
      vsphere_virtual_machine.linux.*.name,
      vsphere_virtual_machine.bare.*.name
    )),
    flatten(list(
      vsphere_virtual_machine.linux.*.id,
      vsphere_virtual_machine.bare.*.id
    )),
  )}"
}

output "virtual_machine_default_ips" {
  description = "The default IP address of each virtual machine deployed, indexed by name"

  value = "${zipmap(
    flatten(list(
      vsphere_virtual_machine.linux.*.name,
      vsphere_virtual_machine.bare.*.name
    )),
    flatten(list(
      vsphere_virtual_machine.linux.*.default_ip_address,
      vsphere_virtual_machine.bare.*.default_ip_address
    )),
  )}"
}

// Global configuration
output "resources_pool_standalone" {
  description = "List resources pool standalone"

  value = "${
    flatten(list(
      vsphere_resource_pool.standalone.*.name
    ))
  }"
}

output "folders" {
  description = "List folder path name"

  value = "${
    flatten(list(
      vsphere_folder.this.*.path
    ))
  }"
}

output "category_name" {
  description = "List tag category name"

  value = "${
    flatten(list(
      vsphere_tag_category.this.*.name
    ))
  }"
}

output "tag_name" {
  description = "List tag(s) name"

  value = "${
    flatten(list(
      vsphere_tag.this.*.name
    ))
  }"
}

output "tag_id" {
  description = "List tag ID(s)"

  value = "${
    flatten(list(
      vsphere_tag.this.*.id
    ))
  }"
}
