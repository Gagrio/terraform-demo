resource "libvirt_volume" "k8s_disk" {
  name   = "k8s-disk"
  pool   = "default"
  size   = 10240  # Size in MB
  format = "qcow2"
}

resource "libvirt_domain" "k8s_vm" {
  name   = "k8s-vm"
  memory = 2048  # Memory in MB
  vcpu   = 2

  disk {
    volume_id = libvirt_volume.k8s_disk.id
  }

  network_interface {
    network_name   = "default"
    addresses      = ["10.0.0.100"]
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  cloudinit {
    user_data = <<EOF
#cloud-config
users:
  - name: george
    ssh_authorized_keys:
      - "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO0Ndoc42s70At7WJAjqQqJpYkltMUV5tpwAUmmNdIpi"
runcmd:
  - dnf update -y
  - dnf install -y podman
  - curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--container-runtime-endpoint unix:///run/podman/podman.sock" sh -
  - mkdir -p /etc/rancher/k3s/
  - cp /var/lib/rancher/k3s/server/tls/client-{key,cert}.pem /etc/rancher/k3s/
  - cp /var/lib/rancher/k3s/server/tls/server-ca.crt /etc/rancher/k3s/ca.pem
EOF
  }
}
