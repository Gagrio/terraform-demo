resource "helm_release" "gitlab" {
  name       = "gitlab"
  repository = "https://charts.gitlab.io"
  chart      = "gitlab"
  namespace  = "gitlab"

  create_namespace = true
  values           = [file("${path.module}/gitlab-values.yaml")]
}
