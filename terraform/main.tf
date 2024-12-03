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
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.3"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

provider "null" {}
