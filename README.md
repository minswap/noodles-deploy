
# noodles-deploy GitOps Monorepo

This repository implements a GitOps workflow for managing both application and infrastructure deployments using ArgoCD in a single management Kubernetes cluster.

## Repository Structure

- **apps/**: Custom application manifests (e.g., noodles-fe, noodles-be) with Kustomize bases and overlays for each environment (dev, staging, prod).
- **infrastructure/**: Infrastructure and middleware (e.g., Redis, monitoring, ArgoCD bootstrap) managed by DevOps.
- **argocd/**: ArgoCD Application, ApplicationSet, and AppProject manifests to control what gets deployed and where.
- **tools/**: Utility scripts for validation and secret generation.

```
├── apps/
│   ├── noodles-fe/
│   │   ├── base/
│   │   └── overlays/
│   └── noodles-be/
│       ├── base/
│       └── overlays/
├── infrastructure/
│   ├── argocd/
│   ├── common/
│   ├── redis/
│   └── monitoring/
├── argocd/
│   ├── app-projects/
│   ├── applications/
│   └── bootstrap/
├── tools/
└── README.md
```

## Deployment Workflow

1. **Bootstrap ArgoCD**:  
   Deploy ArgoCD to your cluster using the manifests in `infrastructure/argocd/`.

2. **Register Repositories**:  
   Use `repository-credentials.yaml` to register this repo with ArgoCD.

3. **App of Apps Pattern**:  
   Apply the core app in `argocd/bootstrap/` (e.g., `noodles-prod-core-app.yaml`) to bootstrap all other ArgoCD Applications and ApplicationSets.

4. **ApplicationSets**:  
   Use ApplicationSets (e.g., `noodles-fe-appset.yaml`) to manage multi-environment deployments for each app.

5. **Kustomize Overlays**:  
   Each app and infrastructure component uses Kustomize overlays for environment-specific configuration.

6. **Image Automation**:  
   ArgoCD Image Updater is configured for automated image tag updates and PRs.

## Validation

- **Validate ArgoCD manifests:**
  ```bash
  ./tools/validate-argocd.sh
  ```
- **Validate Kustomize overlays:**
  ```bash
  ./tools/validate-kustomize.sh
  ```

## Best Practices

- All ArgoCD Application resources should be in the `argocd` namespace.
- Use overlays for environment-specific changes.
- Keep infrastructure and application code separated.
- Use ApplicationSets for scalable, multi-environment deployments.
- Use `yamllint` and `kustomize` for manifest validation.

## Contributing

1. Fork the repo and create your feature branch.
2. Commit your changes and open a PR.
3. Ensure all validation scripts pass before requesting review.
