#!/bin/bash

set -e

# Check if kustomize is installed
if ! command -v kustomize &> /dev/null; then
  echo "Error: kustomize is not installed. Please install kustomize and try again."
  exit 1
fi

# Validate Kustomize overlays in known directories
for base in apps infrastructure; do
  if [ -d "$base" ]; then
    find "$base" -name kustomization.yaml | while read file; do
      dir=$(dirname "$file")
      echo "Validating Kustomize manifests in $dir"
      kustomize build "$dir" > /dev/null || { echo "Kustomize validation failed in $dir"; exit 1; }
    done
  fi
done

echo "All Kustomize overlays are valid."