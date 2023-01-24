resource "kubernetes_network_policy" "redis-replica" {
  metadata {
    name      = "redis"
    namespace = "k8s-workshop"
  }

  spec {
    pod_selector {
      match_labels {
        app = "redis"
      }
    }
    ingress {
      ports {
        port     = "6379"
        protocol = "TCP"
      }

      from {
        pod_selector {
          match_labels = {
            app = "redis"

          }
        }
      }

      egress {} # single empty rule to allow all egress traffic

      policy_types = ["Ingress", "Egress"]
    }
  }
}