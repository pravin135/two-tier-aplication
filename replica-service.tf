resource "kubernetes_service" "redis_replica" {
  metadata {
    name      = "redis-replica"
    namespace = "k8s-workshop"
    labels = {
      app  = "redis"
      role = "replica"
      tier = "backend"
    }
  }
  spec {
    selector = {
      app  = "redis"
      role = "replica"
      tier = "backend"
    }
    port {
      port = 6379
    }
  }
  depends_on = [
    kubernetes_deployment.redis_replica
  ]
}
