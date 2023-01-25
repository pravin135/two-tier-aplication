resource "kubernetes_network_policy" "app" {
  metadata {
    name      = "app"
    namespace = "k8s-workshop"
  }

  spec {
    pod_selector {
      match_labels = {
        app = "webapp"
      }
    }

    ingress {
      ports {
        protocol = "TCP"
        port     = "8080"
      }

      from {
        ip_block {
          cidr = "0.0.0.0/0"
        }
      }
    }

    policy_types = ["Ingress"]
  }
}