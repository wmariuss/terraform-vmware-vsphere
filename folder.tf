// Create folder(s)
resource "vsphere_folder" "this" {
  count         = length(var.create_folders) > 0 ? length(var.create_folders) : 0
  path          = element(var.create_folders, count.index)
  type          = var.folder_type
  datacenter_id = data.vsphere_datacenter.this.id
}
