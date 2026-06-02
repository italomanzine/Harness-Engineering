#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(CDPATH="" cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

feature_dir="${1:-}"

if [[ -z "$feature_dir" && -f ".memory/session-context.json" ]] && command -v jq >/dev/null 2>&1; then
  feature_dir="$(jq -r '.activeFeatureDir // empty' .memory/session-context.json)"
fi

if [[ -z "$feature_dir" && -d "specs" ]]; then
  feature_dir="$(find specs -mindepth 1 -maxdepth 1 -type d | sort | tail -n 1 || true)"
fi

branch="no-git"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch="$(git branch --show-current 2>/dev/null || echo detached)"
fi

echo "Harness Bootstrap Context"
echo "repo: $REPO_ROOT"
echo "branch: $branch"
echo "feature: ${feature_dir:-none}"

if [[ -n "$feature_dir" ]]; then
  for artifact in spec.md plan.md tasks.md evaluation-contract.json; do
    if [[ -f "$feature_dir/$artifact" ]]; then
      echo "$artifact: present"
    else
      echo "$artifact: missing"
    fi
  done
fi

echo
echo "Progress"
if [[ -f ".memory/progress.md" ]]; then
  sed -n '1,120p' .memory/progress.md
else
  echo "missing .memory/progress.md"
fi

echo
echo "Last Evaluation"
if [[ -f ".memory/last-evaluation.json" ]]; then
  if command -v jq >/dev/null 2>&1; then
    jq '{status, featureDir, evaluatedAt, errors}' .memory/last-evaluation.json
  else
    sed -n '1,120p' .memory/last-evaluation.json
  fi
else
  echo "missing .memory/last-evaluation.json"
fi
