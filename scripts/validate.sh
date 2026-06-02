#!/bin/bash
set -euo pipefail

echo "Iniciando validacao do Harness..."

required_files=(
  "AGENTS.md"
  "README.md"
  "GEMINI.md"
  ".github/copilot-instructions.md"
  ".harness/workflow.md"
  ".harness/github-targets.json"
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
  ".stitch/next-prompt.md"
  ".github/prompts/refine.prompt.md"
  ".github/prompts/intent.prompt.md"
  ".github/agents/harness.refine.agent.md"
  ".github/agents/harness.intent.agent.md"
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

if ! jq -e '.mcpServers.stitch.type == "http" and .mcpServers.stitch.url == "https://stitch.googleapis.com/mcp" and (.mcpServers.stitch.headers["X-Goog-Api-Key"] | length > 0)' .mcp.example.json >/dev/null; then
  echo "MCP Stitch HTTP ausente ou mal configurado em .mcp.example.json."
  exit 1
fi

if ! jq -e '
  .productRepository == "italomanzine/Alexandria-UFSC" and
  .harnessRepository == "italomanzine/Harness-Engineering" and
  .projectUrl == "https://github.com/users/italomanzine/projects/3/views/1" and
  .defaultStitchProjectUrl == "https://stitch.withgoogle.com/projects/13111711788255953460?pli=1" and
  .stitchProjectName == "projects/13111711788255953460" and
  .kanban.statusField == "Status" and
  .kanban.statuses.backlog == "Backlog" and
  .kanban.statuses.ready == "Ready" and
  .kanban.statuses.inProgress == "In progress" and
  .kanban.statuses.inReview == "In review"
' .harness/github-targets.json >/dev/null; then
  echo "Targets GitHub/Kanban/Stitch ausentes ou incorretos em .harness/github-targets.json."
  exit 1
fi

if grep -R "Create product Issues/User Stories only in italomanzine/Harness-Engineering" .harness/github-targets.json >/dev/null; then
  echo "Regra invalida: productRepository nao pode apontar para o repo do harness."
  exit 1
fi

if ! grep -R "italomanzine/Alexandria-UFSC" AGENTS.md README.md GEMINI.md .github/copilot-instructions.md .harness/workflow.md .agents/roles .github/prompts >/dev/null; then
  echo "Repositorio de produto italomanzine/Alexandria-UFSC nao encontrado nos contratos principais."
  exit 1
fi

if ! grep -R "https://github.com/users/italomanzine/projects/3/views/1" AGENTS.md README.md GEMINI.md .github/copilot-instructions.md .harness/workflow.md .agents/roles .github/prompts >/dev/null; then
  echo "GitHub Project 3 nao encontrado nos contratos principais."
  exit 1
fi

if ! grep -R "Status=Backlog\|Initial status: Backlog" AGENTS.md README.md .harness/workflow.md .agents/roles .github/prompts >/dev/null; then
  echo "Regra de Backlog para /refine nao encontrada."
  exit 1
fi

if ! grep -R 'Status=Ready\|only `/intent` cards in Ready\|card.*Ready' AGENTS.md README.md .harness/workflow.md .agents/roles .github/prompts >/dev/null; then
  echo "Ready gate de /intent nao encontrado."
  exit 1
fi

if ! grep -R "In progress" AGENTS.md README.md GEMINI.md .harness/workflow.md .agents/roles .github/prompts >/dev/null; then
  echo "Transicao Kanban para In progress nao encontrada."
  exit 1
fi

if ! grep -R "In review" AGENTS.md README.md GEMINI.md .harness/workflow.md .agents/roles .github/prompts >/dev/null; then
  echo "Transicao Kanban para In review nao encontrada."
  exit 1
fi

if ! grep -R "https://stitch.withgoogle.com/projects/13111711788255953460?pli=1" AGENTS.md README.md GEMINI.md .github/copilot-instructions.md .harness/workflow.md .agents/roles .github/prompts .stitch >/dev/null; then
  echo "URL real do prototipo Stitch nao encontrada nos contratos principais."
  exit 1
fi

if ! grep -R "projects/13111711788255953460" AGENTS.md README.md GEMINI.md .github/copilot-instructions.md .harness/workflow.md .agents/roles .github/prompts .stitch >/dev/null; then
  echo "Resource MCP real do Stitch nao encontrado nos contratos principais."
  exit 1
fi

if ! grep -q "Alexandria — High-End Editorial" .stitch/DESIGN.md; then
  echo ".stitch/DESIGN.md nao contem o design real do prototipo."
  exit 1
fi

if ! grep -q "Calculadora de Notas UFSC" .stitch/SITE.md; then
  echo ".stitch/SITE.md nao contem metadados reais do prototipo."
  exit 1
fi

if ! grep -q "^---" .github/prompts/refine.prompt.md || ! grep -q "^---" .github/prompts/intent.prompt.md; then
  echo "Prompts /refine ou /intent sem frontmatter."
  exit 1
fi

bad_docs_file_refs="$(grep -R -E "docs/[A-Za-z0-9_.() -]+\\.(md|html|png|json|sh|txt)" AGENTS.md GEMINI.md .github/copilot-instructions.md .harness .agents/roles .specify/memory/constitution.md || true)"
if [[ -n "$bad_docs_file_refs" ]]; then
  echo "Referencia operacional indevida a arquivo de docs/ encontrada."
  printf "%s\n" "$bad_docs_file_refs"
  exit 1
fi

echo "Harness validado com sucesso."
