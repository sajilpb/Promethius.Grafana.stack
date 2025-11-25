resource "helm_release" "promethius" {
    name             = "promethius"
    repository       = "https://prometheus-community.github.io/helm-charts"
    chart            = "prometheus-community/prometheus"
    namespace        = "monitoring"
    create_namespace = true
}

resource "helm_release" "grafana" {
    name              = "Grafana"
    namespace         = "monitoring"
    repository        = "https://grafana.github.io/helm-charts "
    chart             = "grafana/grafana"
    create_namespace  = true

    values = [
    file("${path.module}/templates/grafana-values.yaml")
  ]
}

data "kubernetes_secret" "grafana" {
  metadata {
    name      = "grafana"
    namespace = "monitoring"
  }

  depends_on = [
    helm_release.grafana
  ]
}
