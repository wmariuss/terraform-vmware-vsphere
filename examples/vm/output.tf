output "virtual_machine_names" {
  value = "${module.vsphere.virtual_machine_names}"
}

output "virtual_machine_ids" {
  value = "${module.vsphere.virtual_machine_ids}"
}

output "virtual_machine_default_ips" {
  value = "${module.vsphere.virtual_machine_default_ips}"
}
