resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "k8s-workshop"
  }
  depends_on = [
    google_container_cluster.primary
  ]
}

