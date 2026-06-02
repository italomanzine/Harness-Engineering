---
description: Refine uma feature em spec SDD e User Stories no backlog do produto.
---

# /refine

Use este prompt quando o usuário pedir `/refine` ou pedir para refinar uma feature.

## Contratos obrigatórios

- Leia `AGENTS.md`, `.harness/workflow.md`, `.agents/roles/product_manager.md` e `.harness/github-targets.json`.
- Execute `scripts/bootstrap-context.sh`.
- Atue como Product Manager.
- Não implemente código.
- Crie ou atualize a spec em `specs/<slug>/spec.md`.
- Use BDD em `Dado / Quando / Então`.
- Crie Issues/User Stories somente em `italomanzine/Alexandria-UFSC`.
- Adicione cada Issue ao Project `https://github.com/users/italomanzine/projects/3/views/1`.
- Defina o campo `Status` de cards novos como `Backlog`.
- Nunca crie User Stories no repositório `italomanzine/Harness-Engineering`.

## Stitch e UI/UX

Quando a feature envolver UI/UX:

- Use o Stitch Project `https://stitch.withgoogle.com/projects/13111711788255953460?pli=1`.
- Use o resource MCP `projects/13111711788255953460`.
- Use `.stitch/DESIGN.md` como fonte visual operacional.
- Inclua no card a meta de 98% de similaridade visual.
- Inclua exigência de evidência visual no PR via screenshots/Playwright.
- Cite as skills `ui-ux-pro-max`, `stitch-loop`, `design-md` e `playwright`.

## Formato mínimo do card

```md
## User Story
Como <persona>, quero <ação>, para <valor>.

## Spec
- Feature spec: specs/<slug>/spec.md
- Requirements: REQ-...
- Scenarios: SCN-...

## Acceptance Criteria
- Dado ..., Quando ..., Então ...

## UI/UX e Stitch
- Stitch Project: https://stitch.withgoogle.com/projects/13111711788255953460?pli=1
- Stitch resource: projects/13111711788255953460
- Design source: .stitch/DESIGN.md
- Similaridade visual mínima: 98%
- Evidência obrigatória: screenshots/Playwright no PR
- Aplicar: ui-ux-pro-max, stitch-loop, design-md, Playwright

## Implementation Target
- Repository: italomanzine/Alexandria-UFSC
- Project: https://github.com/users/italomanzine/projects/3/views/1
- Initial status: Backlog
- Ready gate: only `/intent` cards in Ready
- Branch pattern: feature/<slug>
```

Se o GitHub MCP não conseguir adicionar a Issue ao Project ou mover para `Backlog`, informe o bloqueio explicitamente e registre em `.memory/progress.md`.
