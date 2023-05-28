resource "helm_release" "kube-prometheus-stack" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "kube-prometheus-stack"
  create_namespace = true

  values = [
    "${file("charts/values/kube-prometheus.yaml")}"
  ]

}


resource "helm_release" "argoCD" {
  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = "argo-cd"
  create_namespace = true

  values = [
    "${file("charts/values/argoCD.yaml")}"
  ]

  set {
    # Run server without TLS
    name  = "configs.params.server\\.insecure"
    value = true
  }
}


resource "helm_release" "nginx-controller" {
  name       = "nginx-controller"
  repository = "oci://ghcr.io/nginxinc/charts/"
  chart      = "nginx-ingress"
  namespace  = "nginx-controller"
  create_namespace = true

  set {
    name  = "controller.service.create"
    value = "false"
  }

  set {
    name  = "controller.kind"
    value = "daemonset"
  }

}

resource "helm_release" "elastic-operator" {
  name       = "elastic-operator"
  repository = "https://helm.elastic.co"
  chart      = "eck-operator"
  namespace  = "elastic-operator"
  create_namespace = true
}
