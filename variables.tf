variable "k8s_host" {
  description = "Kubernetes API server endpoint"
  default     = "https://10.0.0.100:6443"
}

variable "k8s_client_certificate" {
  description = "Path to the Kubernetes client certificate"
  default     = "/etc/rancher/k3s/client-cert.pem"
}

variable "k8s_client_key" {
  description = "Path to the Kubernetes client key"
  default     = "/etc/rancher/k3s/client-key.pem"
}

variable "k8s_cluster_ca_certificate" {
  description = "Path to the Kubernetes cluster CA certificate"
  default     = "/etc/rancher/k3s/ca.pem"
}
