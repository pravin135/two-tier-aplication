resource "kubernetes_deployment" "redis-primary" {
  metadata {
    name      = "redis-primary"
    namespace = "k8s-workshop"
  }
  spec {
    replicas = 1
    template {
      metadata {
        labels = {
          "app"  = "redis"
          "role" = "primary"
          "tier" = "backend"
        }
      }
      spec {
        container {
          name  = "redis"
          image = "gcr.io/google_containers/redis:e2e"

          resources {
            limits = {
              cpu    = "100"
              memory = "100Mi"
            }
          }
          port {
            container_port = 6379
          }
        }
      }
    }
  }
}