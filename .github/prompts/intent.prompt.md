---
description: Implementa uma User Story Ready do produto com branch, avaliação e PR.
---

# /intent

Use este prompt quando o usuário pedir `/intent` ou pedir para implementar uma Issue/User Story.

## Contratos obrigatórios

- Leia `AGENTS.md`, `.harness/workflow.md`, `.agents/roles/orchestrator.md` e `.harness/github-targets.json`.
- Execute `scripts/bootstrap-context.sh`.
- Atue como Orchestrator.
- Leia a Issue/card via GitHub MCP no repositório `italomanzine/Alexandria-UFSC`.
- Confirme que a Issue/card está no Project `https://github.com/users/italomanzine/projects/3/views/1`.
- Confirme que o campo `Status` está em `Ready`.
- Se o status não for `Ready`, pare o fluxo e explique o bloqueio.
- Ao iniciar implementação, mova o card para `In progress`.
- Crie branch `feature/<slug>` a partir da `main` no repo `italomanzine/Alexandria-UFSC`.
- Crie/valide `specs/<slug>/plan.md`, `specs/<slug>/tasks.md` e `specs/<slug>/evaluation-contract.json`.
- Implemente no máximo 1 User Story ou 5 tasks por ciclo.
- Use TDD com Red -> Green -> Refactor.
- Rode `scripts/evaluate.sh <feature-dir>`.
- Abra PR para `main` em `italomanzine/Alexandria-UFSC` somente após avaliação `PASS`.
- Depois do PR aberto, mova o card para `In review`.
- Não mova o card para concluído; a validação humana decide o próximo status.

## Stitch e UI/UX

Quando houver UI/UX:

- Use `.stitch/DESIGN.md` como fonte visual operacional.
- Use Stitch Project `https://stitch.withgoogle.com/projects/13111711788255953460?pli=1`.
- Use resource MCP `projects/13111711788255953460`.
- Use `ui-ux-pro-max`, `stitch-loop`, `design-md` e Playwright.
- Gere evidências visuais no PR.
- Busque pelo menos 98% de similaridade visual com o protótipo.

Se o GitHub MCP não conseguir mover o card para `In progress` ou `In review`, informe o bloqueio explicitamente e registre em `.memory/progress.md`.
