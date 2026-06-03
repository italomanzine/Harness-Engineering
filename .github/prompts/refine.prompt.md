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
- Crie Issues/User Stories somente no `productRepository`.
- Adicione cada Issue ao `projectUrl`.
- Defina o campo `Status` de cards novos como `Backlog`.
- Nunca crie User Stories no `harnessRepository`.

## Stitch e UI/UX

Quando a feature envolver UI/UX:

- Use o `defaultStitchProjectUrl`.
- Use o resource MCP `stitchProjectName`.
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
- Stitch Project: <defaultStitchProjectUrl>
- Stitch resource: <stitchProjectName>
- Design source: .stitch/DESIGN.md
- Similaridade visual mínima: 98%
- Evidência obrigatória: screenshots/Playwright no PR
- Aplicar: ui-ux-pro-max, stitch-loop, design-md, Playwright

## Implementation Target
- Repository: <productRepository>
- Project: <projectUrl>
- Initial status: Backlog
- Ready gate: only `/intent` cards in Ready
- Branch pattern: feature/<slug>
```

Se o GitHub MCP não conseguir adicionar a Issue ao Project ou mover para `Backlog`, informe o bloqueio explicitamente e registre em `.memory/progress.md`.
