data "vsphere_datacenter" "this" {
  name = var.datacenter
}

data "vsphere_host" "this" {
  count         = var.esxi_host != "" && var.cluster == "" ? 1 : 0
  name          = var.esxi_host
  datacenter_id = data.vsphere_datacenter.this.id
}

data "vsphere_compute_cluster" "this" {
  count         = var.vm_type == "bare" || var.vm_type == "linux" && var.cluster != "" ? 1 : 0
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.this.id
}

data "vsphere_datastore" "this" {
  count         = var.vm_type == "bare" || var.vm_type == "linux" ? 1 : 0
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.this.id
}

data "vsphere_network" "this" {
  count         = var.vm_type == "bare" || var.vm_type == "linux" ? 1 : 0
  name          = var.port_group
  datacenter_id = data.vsphere_datacenter.this.id
}

data "vsphere_virtual_machine" "this" {
  count         = var.vm_type == "bare" || var.vm_type == "linux" ? 1 : 0
  name          = var.vm_template
  datacenter_id = data.vsphere_datacenter.this.id
}

data "vsphere_resource_pool" "this" {
  count         = var.resource_pool != "" && var.create_resource_pool == false ? 1 : 0
  name          = var.resource_pool
  datacenter_id = data.vsphere_datacenter.this.id
}

// Categories and tags
data "vsphere_tag_category" "this" {
  count = var.tag_category != "" ? 1 : 0
  name  = var.tag_category
}

data "vsphere_tag" "this" {
  count       = length(var.tags) > 0 && var.tag_category != "" ? length(var.tags) : 0
  name        = element(var.tags, count.index)
  category_id = "${element(data.vsphere_tag_category.this.*.id, count.index)}"
}
