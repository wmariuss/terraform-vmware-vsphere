// vSphere module
// Maintainer Marius Stanca <me@marius.xyz>

provider "vsphere" {
  version             = ">= 1.21.0, <= 1.21.1"
  vsphere_server      = var.vsphere_server
  user                = var.vsphere_user
  password            = var.vsphere_password
  allow_unverified_ssl = var.unverified_ssl
}

// Create a VM from a template
resource "vsphere_virtual_machine" "linux" {
  count                       = lower(var.vm_type) == "linux" ? var.number_of_vms : 0
  name                        = var.number_of_vms > 1 ? format("%s-%d", var.name, count.index+1) : var.name
  resource_pool_id            = var.resource_pool != "" ? element(concat(data.vsphere_resource_pool.this.*.id, list("")), 0) : element(data.vsphere_compute_cluster.this.*.resource_pool_id, count.index)
  datastore_id                = element(data.vsphere_datastore.this.*.id, count.index)
  folder                      = element(concat(list(var.folder), list("")), 0)
  annotation                  = var.note
  enable_disk_uuid            = true
  // VM resources
  num_cpus                   = var.vcpu_number
  memory                     = var.memory_size
  num_cores_per_socket       = var.num_cores_per_socket
  // Guest OS
  guest_id                   = element(data.vsphere_virtual_machine.this.*.guest_id, count.index)
  scsi_type                  = element(data.vsphere_virtual_machine.this.*.scsi_type, count.index)
  wait_for_guest_net_timeout = var.wait_for_guest_net_timeout

  // VM storage
  disk {
    label            = var.disk_label
    size             = var.disk_size != "" ? var.disk_size : element(data.vsphere_virtual_machine.this.*.disks.0.size, count.index)
    thin_provisioned = var.linked_clone ? element(data.vsphere_virtual_machine.this.*.disks.0.thin_provisioned, count.index) : true
    eagerly_scrub    = var.linked_clone ? element(data.vsphere_virtual_machine.this.*.disks.0.eagerly_scrub, count.index) : false
  }

  // VM networking
  network_interface {
    network_id   = element(data.vsphere_network.this.*.id, count.index)
    adapter_type = element(data.vsphere_virtual_machine.this.*.network_interface_types[0], count.index)
  }

  // Customization of the VM
  clone {
    template_uuid = element(data.vsphere_virtual_machine.this.*.id, count.index)

    customize {
      linux_options {
        host_name = var.number_of_vms > 1 ? format("%s-%d", var.name, count.index+1) : var.name
        domain    = var.domain
        time_zone = var.time_zone
      }

      network_interface {
        ipv4_address = var.ipv4_network_address != "0.0.0.0/0" ? cidrhost(var.ipv4_network_address, var.ipv4_address_start + count.index) : var.ipv4_address
        ipv4_netmask = var.ipv4_network_address != "0.0.0.0/0" ? element(split("/", var.ipv4_network_address), 1) : var.ipv4_netmask
      }

      ipv4_gateway    = var.ipv4_gateway != "" ? var.ipv4_gateway : ""
      dns_server_list = var.dns_servers
      dns_suffix_list  = [var.domain]
    }
  }

  connection {
    type     = "ssh"
    host     = self.default_ip_address
    user     = var.provisioner_user
    password = var.provisioner_password
    port     = var.provisioner_port
  }

  provisioner "file" {
    source      = var.provisioner_source_file
    destination = var.provisioner_destination_file
  }

  provisioner "remote-exec" {
    inline = var.provisioner_remote_commands
  }

  tags = compact(concat(list(length(var.tags) > 0 ? join("", data.vsphere_tag.this.*.id) : "")))
}

// DRS anti-affinity
resource "vsphere_compute_cluster_vm_anti_affinity_rule" "linux" {
  count               = var.enable_anti_affinity_rule && lower(var.vm_type) == "linux" ? 1 : 0
  name                = "${var.name}-rule"
  compute_cluster_id  = element(data.vsphere_compute_cluster.this.*.id, count.index)
  virtual_machine_ids = [element(vsphere_virtual_machine.linux.*.id, count.index)]
}
