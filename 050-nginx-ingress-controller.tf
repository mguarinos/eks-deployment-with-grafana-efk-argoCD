resource "kubernetes_service_v1" "InternetLoadBalancer" {
  metadata {
    name = "ingress-service"
    namespace = "nginx-controller"
  }
  spec {
    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }
    type = "LoadBalancer"
    selector = {
      "app.kubernetes.io/name" = "nginx-ingress"
    }

  }
}

locals {
  internet_load_balancer_hostname = kubernetes_service_v1.InternetLoadBalancer.status.0.load_balancer.0.ingress.0.hostname
}
