variable "vm_memory" {
  description = "Memory in MB for the VM"
  default     = 4096
}

variable "vm_cpus" {
  description = "Number of CPUs for the VM"
  default     = 1
}

variable "disk_size" {
  description = "Disk size in GB"
  default     = 20
}

variable "cert_cluster_ca" {
  description = "Base64 encoded CA certificate for the Kubernetes cluster"
  default     = "/etc/rancher/k3s/k3s.yaml"
  type        = string
}

variable "cert_client_cert" {
  description = "Base64 encoded client certificate for Kubernetes"
  default     = "/etc/rancher/k3s/credentials/client.crt"
  type        = string
}

variable "cert_client_key" {
  description = "Base64 encoded client key for Kubernetes"
  default     = "/etc/rancher/k3s/credentials/client.key"
  type        = string
}
