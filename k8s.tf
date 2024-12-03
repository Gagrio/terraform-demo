# Move this to terraform directory once the VM and k3s is up to configure the hello-world kubernetes app.
provider "kubernetes" {
  host                   = "https://192.168.64.100:6443"
  cluster_ca_certificate = file(var.cert_cluster_ca)
  client_certificate     = file(var.cert_client_cert)
  client_key             = file(var.cert_client_key)
}

resource "kubernetes_namespace" "default" {
  metadata {
    name = "default"
  }
}

resource "kubernetes_deployment" "hello_world" {
  metadata {
    name = "hello-world"
    labels = {
      app = "hello-world"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "hello-world"
      }
    }
    template {
      metadata {
        labels = {
          app = "hello-world"
        }
      }
      spec {
        container {
          name  = "hello-world"
          image = "nginx:latest"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "hello_world" {
  metadata {
    name = "hello-world"
  }

  spec {
    selector = {
      app = kubernetes_deployment.hello_world.spec.0.template.0.metadata.0.labels.app
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }
}
