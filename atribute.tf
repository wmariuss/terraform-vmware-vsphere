// Create custom attribute(s)
resource "vsphere_custom_attribute" "attribute" {
  count               = length(var.create_custom_attributes) > 0 ? length(var.create_custom_attributes) : 0
  name                = element(var.create_custom_attributes, count.index)
  managed_object_type = "VirtualMachine"
}
