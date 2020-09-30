# Create VM from scratch
resource "vsphere_virtual_machine" "bare" {
  count            = lower(var.vm_type) == "bare" ? var.number_of_vms : 0
  name             = var.number_of_vms > 1 ? format("%s-%d", var.name, count.index+1) : var.name
  resource_pool_id = var.resource_pool != "" ? element(concat(data.vsphere_resource_pool.this.*.id, list("")), 0) : element(data.vsphere_compute_cluster.this.*.resource_pool_id, count.index)
  datastore_id     = element(data.vsphere_datastore.this.*.id, count.index)
  folder           = element(concat(list(var.folder), list("")), 0)
  num_cpus         = var.vcpu_number
  memory           = var.memory_size
  guest_id         = var.guest_id
  annotation       = var.note

  wait_for_guest_net_timeout = var.wait_for_guest_net_timeout

  network_interface {
    network_id = element(data.vsphere_network.this.*.id, count.index)
  }

  disk {
    label = var.disk_label
    size  = var.disk_size
  }

  tags = compact(concat(list(length(var.tags) > 0 ? join("", data.vsphere_tag.this.*.id) : "")))
}

# DRS anti-affinity
resource "vsphere_compute_cluster_vm_anti_affinity_rule" "bare" {
  count               = var.enable_anti_affinity_rule && var.vm_type == "bare" ? 1 : 0
  name                = "${var.name}-rule"
  compute_cluster_id  = element(data.vsphere_compute_cluster.this.*.id, count.index)
  virtual_machine_ids = element(vsphere_virtual_machine.bare.*.id, count.index)
}
