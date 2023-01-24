resource "kubernetes_network_policy" "redis-replica" {
  metadata {
    name      = "redis"
    namespace = "k8s-workshop"
  }

  spec {
    pod_selector {
      match_labels = {
        app = "redis"
      }
      policy_types = ["Ingress"]
    }
    from {
        pod_selector {
          match_labels = {
            app = "redis"

          }
        }
      }
    ingress {
      ports {
        port     = "6379"
        protocol = "TCP"
     }
      

    }
  }
}