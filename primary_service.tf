resource "kubernetes_service" "redis_primary" {
  metadata {
    name = "redis_primary"
    namespace = "k8s-workshop"
  }
  template {
      metadata {
        labels = {
          app  = "redis"
          role = "primary"
          tier = "backend"
        }
      }
  spec {
    selector = {
      app = "redis"
      role = "primary"
      tier = "backend"
    }
    port {
      port        = 6379
      target_port = 6379
    }

    type = "LoadBalancer"
  }
}
}