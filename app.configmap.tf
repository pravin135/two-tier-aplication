resource "kubernetes_config_map" "webapp" {
  metadata {
    name      = "webapp"
    namespace = "k8s-workshop"
  }

  data = {
    "app.dependency.require_tls" = "truex"

    "app.dependency.url" = "https://test.dependency.foo.bar/api/v1/"
  }
}
