provider "libvirt" {
  uri = "qemu:///system"
}

provider "helm" {
  kubernetes {
    host                   = var.k8s_host
    client_certificate     = file(var.k8s_client_certificate)
    client_key             = file(var.k8s_client_key)
    cluster_ca_certificate = file(var.k8s_cluster_ca_certificate)
  }
}
