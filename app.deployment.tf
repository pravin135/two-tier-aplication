resource "kubernetes_deployment" "webapp" {
  metadata {
    name      = "webapp"
    namespace = "k8s-workshop"

    annotations = {
      "flux.weave.works/automated" = "true"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "webapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "webapp"
        }
      }

      spec {
        volume {
          name = "secrets"

          secret {
            secret_name = "webapp"

            items {
              key  = "val2"
              path = "secret_file"
              mode = 0511
            }
          }
        }

        container {
          name    = "webapp"
          image   = "quay.io/fairwinds/k8s-workshop:latest"
          command = ["ruby", "app/app.rb"]

          port {
            name           = "http"
            container_port = 8080
          }

          env {
            name  = "REDIS_HOST"
            value = "redis-primary"
          }

          env {
            name  = "REDIS_PORT"
            value = "6379"
          }

          env {
            name = "SECRET1"

            value_from {
              secret_key_ref {
                name = "webapp"
                key  = "val1"
              }
            }
          }

          env {
            name = "DEPENDENCY_URL"

            value_from {
              config_map_key_ref {
                name = "webapp"
                key  = "app.dependency.url"
              }
            }
          }

          env {
            name = "DEPENDENCY_REQUIRE_TLS"

            value_from {
              config_map_key_ref {
                name = "webapp"
                key  = "app.dependency.require_tls"
              }
            }
          }

          resources {
            limits = {
              cpu = "200m"

              memory = "300Mi"
            }

            requests = {
              cpu = "200m"

              memory = "300Mi"
            }
          }

          volume_mount {
            name       = "secrets"
            mount_path = "/etc/secrets"
          }

          liveness_probe {
            http_get {
              path   = "/"
              port   = "8080"
              scheme = "HTTP"
            }

            initial_delay_seconds = 3
            timeout_seconds       = 1
            period_seconds        = 3
            success_threshold     = 1
            failure_threshold     = 3
          }

          readiness_probe {
            http_get {
              path   = "/"
              port   = "8080"
              scheme = "HTTP"
            }

            failure_threshold = 1
          }

          image_pull_policy = "IfNotPresent"
        }
      }
    }
  }
}