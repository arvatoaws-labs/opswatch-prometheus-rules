# opswatch-prometheus-rules

These rules can be appliead using flux:
````
---
apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: GitRepository
metadata:
  name: opswatch-prometheus-rules
  namespace: flux-system
spec:
  interval: 23m
  url: https://github.com/arvatoaws-labs/opswatch-prometheus-rules
  ref:
    branch: main
---
apiVersion: kustomize.toolkit.fluxcd.io/v1beta1
kind: Kustomization
metadata:
  name: opswatch
  namespace: flux-system
spec:
  interval: 10m0s
  path: ./
  dependsOn:
  - name: basics
  - name: prometheus-release
  prune: true
  sourceRef:
    kind: GitRepository
    name: opswatch-prometheus-rules
  validation: client
````

Prometheus needs to scrape an additional target, this is an example config used by the prometheus operator
````
prometheusSpec:
  additionalScrapeConfigs:
  - job_name: opswatch_metrics_xxx
    scrape_interval: 150s
    honor_labels: true
    scheme: https
    oauth2:
      client_id: CLIENT_ID_PROVIDED_BY_ARVATO
      client_secret: CLIENT_SECRET_PROVIDED_BY_ARVATO
      token_url: https://opswatch.auth.eu-central-1.amazoncognito.com/oauth2/token
    static_configs:
    - targets:
      - URL_PROVIDED_BY_ARVATO
````

These placeholders need to be replaced:
* CLIENT_ID_PROVIDED_BY_ARVATO
* CLIENT_SECRET_PROVIDED_BY_ARVATO
* URL_PROVIDED_BY_ARVATO
