# Create VM
resource "libvirt_volume" "boot_iso" {
  name   = "Fedora.iso"
  source = "/home/george/Downloads/Fedora.iso"
  pool   = "default"
  format = "iso"
}

resource "libvirt_volume" "vm_disk" {
  name   = "vm-disk.qcow2"
  size   = var.disk_size * 1024
  pool   = "default"
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
    hostname     = "terraform-demo"
    network_name = "default"
    mac          = "00:00:00:00:00:06"
    addresses    = ["192.168.64.99"]
  }

  boot_device {
    dev = ["cdrom", "hd"]
  }

  # Enable this after VM is created
  #  provisioner "local-exec" {
  #  command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i /home/george/repos/terraform-demo/ansible/inventory.ini /home/george/repos/terraform-demo/ansible/playbook.yaml"
  #}

}
