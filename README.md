# Promethius.Grafana.stack

Kubernetes Helm deployments for Prometheus and Grafana used for monitoring and dashboards.

## Overview

- **Purpose**: Quick reference to install and expose Prometheus and Grafana using Helm and `kubectl`.

## Commands

### Prometheus

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus
```

Expose Prometheus (port-forward example):

```bash
kubectl --namespace monitoring port-forward prometheus-server-647498958b-flr7b 9090:9090
```

### Grafana

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana grafana/grafana
```

Expose Grafana (port-forward example):

```bash
kubectl --namespace monitoring port-forward grafana-cfb44bd6d-f7tcp 3000:3000
```

### Get Grafana Admin Password

```bash
kubectl -n monitoring get secret grafana -o jsonpath="{.data.admin-password}" | base64 -d
```

## Notes

- Helm releases may create different pod names; replace the pod names above with the actual pod name from `kubectl -n monitoring get pods`.
- Consider installing both charts into a `monitoring` namespace (`-n monitoring`) and creating the namespace first if needed.

## Terraform example

Add the following to the end of your Terraform configuration to pull this repo as a module:

```hcl
#########################################
# Promethius and Grafana stack
#########################################
module "monitoring" {
	source = "git::https://github.com/sajilpb/Promethius.Grafana.stack.git"
	depends_on = [ module.csiaddon, module.eks ]
}
```

If you want Terraform to install the stack and add Prometheus as a Grafana datasource automatically, add this module to your root modules and extend it with any provider or datasource configuration you need.

