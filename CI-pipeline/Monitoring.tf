resource "helm_release" "prometheus" {
  name       = "prometheus"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "65.1.0"
  create_namespace = true

  set = [
    {
      name  = "grafana.adminPassword"
      value = "MyStrongPassword123"
    }
  ]

  depends_on = [
    module.eks
  ]
}
