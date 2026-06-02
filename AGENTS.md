# Harness Engineering Demo

Este repositório é um exemplo didático de Harness Engineering para agentes de IA no desenvolvimento de software.

## Regra de Ouro

Nunca desenvolva direto na `main` ou `master`.

Todo fluxo `/intent` deve:
1. Ler a User Story no GitHub Project/Issue.
2. Ler `specs/<slug>/spec.md`.
3. Criar `specs/<slug>/plan.md`, `specs/<slug>/tasks.md` e `specs/<slug>/evaluation-contract.json`.
4. Atualizar a base local a partir da `main`.
5. Criar uma branch `feature/<slug-da-us>`.
6. Implementar no máximo 1 User Story ou 5 tasks por ciclo com TDD.
7. Declarar `ready_for_evaluation`.
8. Rodar `scripts/evaluate.sh <feature-dir>`.
9. Abrir PR para `main` usando GitHub MCP somente se a avaliação retornar `0`.

## Backbone SDD

Use o GitHub Spec Kit como backbone conceitual:

```text
Spec -> Plan -> Tasks -> Implement
```

Artefatos:

```text
specs/<slug>/
├── spec.md
├── plan.md
└── tasks.md
```

Use `.agents/skills/tlc-spec-driven/SKILL.md` como skill auxiliar para auto-sizing, memória, mapeamento brownfield e retomada.

## Fontes Operacionais

O harness deve usar somente estas fontes para operar:
- `AGENTS.md`
- `.github/copilot-instructions.md`
- `GEMINI.md`
- `.harness/workflow.md`
- `.harness/browser-validation.md`
- `.agents/roles/`
- `.agents/skills/`
- `.specify/`
- `.stitch/`
- `specs/`
- `scripts/validate.sh`
- `scripts/evaluate.sh`
- `scripts/bootstrap-context.sh`

A pasta `docs/` é apenas material de exemplo e inspiração para a palestra. Não use arquivos de `docs/` como dependência direta de `/refine`, `/intent`, revisão, validação ou PR.

## Fluxos Principais

### `/refine`

Use o agente [Product Manager](.agents/roles/product_manager.md).

Objetivo:
- Refinar uma ideia de feature com abordagem Spec Driven Development.
- Criar uma spec Markdown em `specs/<slug>/spec.md`.
- Escrever critérios BDD em `Dado / Quando / Então`.
- Criar ou atualizar cards de User Story no GitHub Project via GitHub MCP.
- Registrar critérios de aceite, design esperado, dependências e riscos.

### `/intent`

Use o agente [Orchestrator](.agents/roles/orchestrator.md).

Objetivo:
- Pegar uma US do GitHub Project/Issue.
- Ler a spec correspondente em `specs/<slug>/spec.md`.
- Criar/validar `plan.md` e `tasks.md`.
- Criar branch `feature/<slug>`.
- Delegar plano técnico ao Architect e implementação ao Coder.
- Implementar com TDD, validar com Evaluator, revisar com Reviewer e abrir PR.
- Anexar evidências visuais na discussão do PR quando houver UI.

## Agentes

- Product Manager: refina feature, cria spec e User Stories.
- Orchestrator: coordena estados do harness e delega trabalho.
- Architect: transforma spec em plano técnico.
- Coder: implementa seguindo TDD, Clean Code e design Stitch.
- Evaluator: executa sensores determinísticos e emite `PASS` ou `FAIL`.
- Reviewer: revisa diff, drift, PR, segurança e aderência a spec.

## MCPs Esperados

- GitHub MCP: Issues, Projects, branches, PRs, comentários e anexos.
- Stitch MCP: leitura do protótipo, geração/consulta de telas e screenshots.

## Skills Recomendadas

- `.skills/tdd-logic.md`
- `.skills/clean-code.md`
- `.agents/skills/stitch-loop/SKILL.md`
- `.agents/skills/design-md/SKILL.md`
- `.agents/skills/enhance-prompt/SKILL.md`
- `.agents/skills/ui-ux-pro-max/SKILL.md`
- `.agents/skills/playwright/SKILL.md`
- `.agents/skills/chrome-devtools/SKILL.md`
- `.agents/skills/review-diff/SKILL.md`
- `.agents/skills/subagent-driven-development/SKILL.md`
- `.agents/skills/tlc-spec-driven/SKILL.md`

## Validação

Antes de concluir qualquer fluxo:

```bash
rtk bash scripts/validate.sh
```

Antes de abrir PR em `/intent`:

```bash
rtk bash scripts/evaluate.sh specs/<slug>
```

Se os comandos de sensores não fizerem sentido no projeto de destino, adapte `.harness/sensors.json` para chamar os comandos reais de lint, testes, build e validação visual.

## UI/UX

Para qualquer mudança visual ou interativa, use `.agents/skills/ui-ux-pro-max/SKILL.md` junto com Stitch.

Use `.agents/skills/playwright/SKILL.md` como ferramenta principal para abrir navegador, manipular UI, coletar snapshots de DOM/acessibilidade e capturar screenshots.

Use `.agents/skills/chrome-devtools/SKILL.md` apenas como diagnóstico complementar para console, rede, performance traces e problemas específicos do Chrome.

O mínimo esperado é verificar:
- acessibilidade e contraste;
- alvos de toque e estados de interação;
- responsividade;
- hierarquia visual;
- tipografia e espaçamento;
- consistência com `.stitch/DESIGN.md`.
