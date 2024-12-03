resource "libvirt_volume" "boot_iso" {
  name   = "boot.iso"
  pool   = "default"
  source = "../eib/eib.iso"
  format = "iso"
}

resource "libvirt_volume" "vm_disk" {
  name   = "vm-disk.qcow2"
  pool   = "default"
  size   = var.disk_size * 1024
  format = "qcow2"
}

resource "libvirt_domain" "vm" {
  name   = "terraform-demo"
  memory = var.vm_memory
  vcpu   = var.vm_cpus

  disk {
    volume_id = libvirt_volume.vm_disk.id
  }

  disk {
    volume_id = libvirt_volume.boot_iso.id
    scsi      = false
  }

  network_interface {
    network_name = "default"
    mac_address  = "00:00:00:00:00:06"
    addresses    = ["192.168.64.100"]
  }

  boot {
    dev = ["cdrom", "hd"]
  }
}
