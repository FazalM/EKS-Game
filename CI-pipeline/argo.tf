resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "8.3.0"
  create_namespace = true

  set = [
    {
      name  = "server.service.type"
      value = "LoadBalancer"
    }
  ]
}