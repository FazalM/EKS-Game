locals {
  grafana_admin_user     = trimspace(file("${path.module}/../user.txt"))
  grafana_admin_password = trimspace(file("${path.module}/../password.txt")) 
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "65.1.0"
  create_namespace = true

  replace          = true
  force_update     = true
  recreate_pods    = true

  set = [
    {
      name  = "grafana.adminUser"
      value = local.grafana_admin_user
    },
    {
      name  = "grafana.adminPassword"
      value = local.grafana_admin_password
    }
  ]

  depends_on = [
    module.eks
  ]
}
