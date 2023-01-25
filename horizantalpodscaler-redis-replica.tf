resource "kubernetes_horizontal_pod_autoscaler" "redis_replica" {
  metadata {
    name      = "redis-replica"
    namespace = "k8s-workshop"
  }

  spec {
    max_replicas                      = 5
    min_replicas                      = 1
    target_cpu_utilization_percentage = 20


    scale_target_ref {
      kind = "Deployment"
      name = "redis-replica"
    }
  }
  depends_on = [
    kubernetes_deployment.redis_replica
  ]
}
