resource "kubernetes_deployment" "redis_primary" {
  metadata {
    name      = "redis-primary"
    namespace = "k8s-workshop"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "redis"
      }
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
        container {
          name  = "redis"
          image = "gcr.io/google_containers/redis:e2e"
          port {
            container_port = 6379
          }
            resources {
              limits = {
                cpu    = "100m"
                memory = "100Mi"
              }
            }
          }
        }
      }
    }
  }