// Create category for the tag(s)
resource "vsphere_tag_category" "this" {
  count            = var.create_tag_category != "" ? 1 : 0
  name             = var.create_tag_category
  cardinality      = var.category_cardinality
  description      = var.category_description
  associable_types = var.category_associable_types
}

// Create tag(s)
resource "vsphere_tag" "this" {
  count       = length(var.create_tags) > 0 && var.create_tag_category != "" ? length(var.create_tags) : 0
  name        = element(var.create_tags, count.index)
  category_id = element(vsphere_tag_category.this.*.id, count.index)
  description = var.tags_description
}
