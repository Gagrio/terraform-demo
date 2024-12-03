terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = ">= 0.6.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

provider "kubernetes" {
  host                   = "https://192.168.64.100:6443"
  cluster_ca_certificate = file(var.cert_cluster_ca)
  client_certificate     = file(var.cert_client_cert)
  client_key             = file(var.cert_client_key)
}
