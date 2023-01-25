resource "kubernetes_network_policy" "redis" {
  metadata {
    name      = "redis"
    namespace = "k8s-workshop"
  }

  spec {
    pod_selector {
      match_labels = {
        app = "redis"
      }
    }

    ingress {
      ports {
        protocol = "TCP"
        port     = "6379"
      }

      from {
        pod_selector {
          match_labels = {
            app = "webapp"
          }
        }
      }
    }

    policy_types = ["Ingress"]
  }
}

