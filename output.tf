output "endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}

output "load_balancer_hostname" {
  value = kubernetes_service_v1.InternetLoadBalancer.status.0.load_balancer.0.ingress.0.hostname
}
