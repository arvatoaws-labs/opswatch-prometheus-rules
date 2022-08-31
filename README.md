# opswatch-prometheus-rules

These rules can be appliead using flux:
```
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
  ```
