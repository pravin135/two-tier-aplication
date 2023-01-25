resource "kubernetes_service" "redis_primary" {
  metadata {
    name      = "redis-primary"
    namespace = "k8s-workshop"
  }
  spec {
    selector = {
      app  = "redis"
      role = "primary"
      tier = "backend"
    }
    port {
      port        = 6379
      target_port = 6379
    }
  }
  depends_on = [
    kubernetes_deployment.primary
  ]
}
