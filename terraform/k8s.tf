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
          ports {
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
