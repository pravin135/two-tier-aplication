resource "kubernetes_deployment" "redis_replica" {
  metadata {
    name      = "redis-replica"
    namespace = "k8s-workshop"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app  = "redis"
        role = "replica"
        tier = "backend"
      }
    }
    template {
      metadata {
        labels = {
          app  = "redis"
          role = "replica"
          tier = "backend"
        }
      }
      spec {
        container {
          name  = "replica"
          image = "gcr.io/google_samples/gb-redisslave:v2"
          port {
            container_port = 6379
          }
          resources {
            limits = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
          env {
            name  = "GET_HOSTS_FROM"
            value = "env"
          }
          env {
            name  = "REDIS_MASTER_SERVICE_HOST"
            value = "redis-primary"
          }
        }
      }
    }
  }
  depends_on = [
    kubernetes_deployment.redis_primary
  ]
}