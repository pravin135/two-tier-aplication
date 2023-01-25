resource "kubernetes_horizontal_pod_autoscaler" "webapp" {
  metadata {
    name      = "webapp"
    namespace = "k8s-workshop"
  }

  spec {
    scale_target_ref {
      kind        = "Deployment"
      name        = "webapp"
      api_version = "apps/v1"
    }

    min_replicas                      = 1
    max_replicas                      = 50
    target_cpu_utilization_percentage = 30
  }
}