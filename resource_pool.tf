// Create resource pool using standalone host
resource "vsphere_resource_pool" "standalone" {
  count                   = var.create_resource_pool && var.resource_pool != "" && var.esxi_host != "" ? 1 : 0
  name                    = var.resource_pool
  parent_resource_pool_id = element(data.vsphere_host.this.*.resource_pool_id, count.index)
}
