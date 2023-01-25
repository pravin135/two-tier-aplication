resource "kubernetes_service" "webapp" {
  metadata {
    name      = "webapp"
    namespace = "k8s-workshop"

    labels = {
      app = "webapp"
    }
  }

  spec {
    port {
      name        = "http"
      protocol    = "TCP"
      port        = 80
      target_port = "http"
    }

    selector = {
      app = "webapp"
    }

    type = "LoadBalancer"
  }
}