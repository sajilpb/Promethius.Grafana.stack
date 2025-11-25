output "grafana_admin_password" {
  description = "Grafana admin password"
  value       = replace(base64decode(data.kubernetes_secret.grafana.data["admin-password"]), "\n", "")
  sensitive   = true
}
