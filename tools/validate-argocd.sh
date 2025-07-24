#!/bin/bash
set -e

# Validate ArgoCD Application manifests
if [ ! -d argocd/applications ]; then
  echo "Directory argocd/applications does not exist!"
  exit 1
fi


find argocd/applications -name '*.yaml' | while read file; do
  echo "Validating ArgoCD manifest: $file"
  yamllint "$file" || { echo "Invalid YAML in $file"; exit 1; }
done

echo "All ArgoCD manifests are valid YAML."