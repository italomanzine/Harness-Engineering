#!/bin/bash
set -euo pipefail

echo "Iniciando validacao do Harness..."

required_files=(
  "AGENTS.md"
  "README.md"
  "GEMINI.md"
  ".github/copilot-instructions.md"
  ".harness/workflow.md"
  ".agents/roles/product_manager.md"
  ".agents/roles/orchestrator.md"
  ".agents/roles/architect.md"
  ".agents/roles/coder.md"
  ".agents/roles/evaluator.md"
  ".agents/roles/reviewer.md"
  ".harness/sensors.json"
  ".harness/browser-validation.md"
  "scripts/evaluate.sh"
  "scripts/bootstrap-context.sh"
  ".memory/session-context.json"
  ".memory/progress.md"
  ".memory/decision-log.md"
  ".memory/last-evaluation.json"
  ".stitch/DESIGN.md"
  ".stitch/SITE.md"
)

for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Arquivo obrigatorio ausente: $file"
    exit 1
  fi
done

for skill in \
  ".skills/tdd-logic.md" \
  ".skills/clean-code.md" \
  ".agents/skills/stitch-loop/SKILL.md" \
  ".agents/skills/design-md/SKILL.md" \
  ".agents/skills/enhance-prompt/SKILL.md" \
  ".agents/skills/ui-ux-pro-max/SKILL.md" \
  ".agents/skills/playwright/SKILL.md" \
  ".agents/skills/chrome-devtools/SKILL.md" \
  ".agents/skills/review-diff/SKILL.md" \
  ".agents/skills/subagent-driven-development/SKILL.md" \
  ".agents/skills/tlc-spec-driven/SKILL.md"; do
  if [[ ! -f "$skill" ]]; then
    echo "Skill obrigatoria ausente: $skill"
    exit 1
  fi
done

if ! grep -R "feature/<slug>" AGENTS.md .harness/workflow.md .github/copilot-instructions.md >/dev/null; then
  echo "Regra de branch feature/<slug> nao encontrada nos contratos principais."
  exit 1
fi

for template in \
  ".specify/constitution.md" \
  ".specify/memory/constitution.md" \
  ".specify/templates/spec-template.md" \
  ".specify/templates/plan-template.md" \
  ".specify/templates/tasks-template.md" \
  ".specify/scripts/bash/create-new-feature.sh" \
  ".specify/scripts/bash/setup-plan.sh" \
  ".specify/scripts/bash/setup-tasks.sh" \
  ".github/prompts/speckit.specify.prompt.md" \
  ".github/prompts/speckit.plan.prompt.md" \
  ".github/prompts/speckit.tasks.prompt.md" \
  ".github/prompts/speckit.implement.prompt.md"; do
  if [[ ! -f "$template" ]]; then
    echo "Artefato SDD/TDD/BDD ausente: $template"
    exit 1
  fi
done

if ! grep -R "Red -> Green -> Refactor" AGENTS.md README.md .harness/workflow.md >/dev/null; then
  echo "Regra TDD Red -> Green -> Refactor nao encontrada nos contratos principais."
  exit 1
fi

if ! grep -R "Dado / Quando / Então" AGENTS.md README.md .harness/workflow.md >/dev/null; then
  echo "Regra BDD Dado / Quando / Entao nao encontrada nos contratos principais."
  exit 1
fi

if ! grep -R "evaluation-contract.json" AGENTS.md README.md .harness/workflow.md .agents/roles .specify/memory/constitution.md >/dev/null; then
  echo "Contrato de avaliacao nao encontrado nos contratos principais."
  exit 1
fi

if ! grep -R "scripts/evaluate.sh" AGENTS.md README.md .harness/workflow.md .github/copilot-instructions.md .specify/memory/constitution.md >/dev/null; then
  echo "Gate scripts/evaluate.sh nao encontrado nos contratos principais."
  exit 1
fi

if ! jq -e '.sensors.harness.command | length > 0' .harness/sensors.json >/dev/null; then
  echo "Sensor harness ausente ou sem comando."
  exit 1
fi

bad_docs_file_refs="$(grep -R -E "docs/[A-Za-z0-9_.() -]+\\.(md|html|png|json|sh|txt)" AGENTS.md GEMINI.md .github/copilot-instructions.md .harness .agents/roles .specify/memory/constitution.md || true)"
if [[ -n "$bad_docs_file_refs" ]]; then
  echo "Referencia operacional indevida a arquivo de docs/ encontrada."
  printf "%s\n" "$bad_docs_file_refs"
  exit 1
fi

echo "Harness validado com sucesso."
