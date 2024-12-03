terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = ">= 0.6.0"
    }
    #    kubernetes = {
    #  source  = "hashicorp/kubernetes"
    #  version = "~> 2.0"
    #}
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}
