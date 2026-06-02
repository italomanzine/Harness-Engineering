# GitHub Copilot Instructions

Este repositório demonstra Harness Engineering para uma palestra.

`docs/` é somente material de apoio e inspiração. Para operar o harness, use os contratos em `AGENTS.md`, `.harness/`, `.agents/`, `.specify/`, `.stitch/`, `specs/` e `scripts/`.

## Fluxos

- Use `/refine` para transformar uma ideia em spec SDD e cards de User Story.
- Use `/intent` para implementar uma User Story existente.
- O backbone SDD é GitHub Spec Kit: `Spec -> Plan -> Tasks -> Implement`.
- A skill auxiliar para execução adaptativa é `.agents/skills/tlc-spec-driven/SKILL.md`.

## Regras para `/refine`

- Atue como Product Manager.
- Escreva a spec em `specs/<slug>/spec.md`.
- Use `.specify/templates/spec-template.md`.
- Inclua cenários BDD em `Dado / Quando / Então`.
- Crie ou atualize cards no GitHub Project via GitHub MCP.
- Não implemente código neste fluxo.

## Regras para `/intent`

- Leia a Issue/card e a spec correspondente.
- Crie ou valide `specs/<slug>/plan.md`, `specs/<slug>/tasks.md` e `specs/<slug>/evaluation-contract.json`.
- Nunca commite direto em `main` ou `master`.
- Crie `feature/<slug>` a partir da `main`.
- Implemente no máximo 1 User Story ou 5 tasks por ciclo com TDD: Red -> Green -> Refactor.
- Cubra cenários BDD com testes automatizados ou evidência justificada.
- Rode `scripts/validate.sh`.
- Rode `scripts/evaluate.sh <feature-dir>`.
- Abra PR para `main` via GitHub MCP somente após avaliação `PASS`.

## Frontend com Stitch

- Use Stitch MCP quando houver design/protótipo. O servidor deve estar configurado como `stitch` em `.mcp.json`, usando HTTP em `https://stitch.googleapis.com/mcp` com header `X-Goog-Api-Key`.
- Use `.agents/skills/ui-ux-pro-max/SKILL.md` para melhorar precisão de UI/UX.
- Use `.agents/skills/playwright/SKILL.md` como browser principal para jornadas, snapshots e screenshots.
- Use `.agents/skills/chrome-devtools/SKILL.md` apenas para diagnóstico de console, rede, performance e DOM ao vivo.
- Use `.stitch/DESIGN.md` como fonte visual.
- Busque pelo menos 98% de similaridade visual com o protótipo.
- Verifique acessibilidade, touch targets, responsividade, hierarquia visual, tipografia, cores e estados de interação.
- Poste screenshots ou evidências visuais na discussão do PR.

## Agentes

- Product Manager: `.agents/roles/product_manager.md`
- Orchestrator: `.agents/roles/orchestrator.md`
- Architect: `.agents/roles/architect.md`
- Coder: `.agents/roles/coder.md`
- Evaluator: `.agents/roles/evaluator.md`
- Reviewer: `.agents/roles/reviewer.md`

<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan
<!-- SPECKIT END -->
