# Tasks: Calculadora de Sobrevivencia Academica

**Input**: `specs/calculadora-sobrevivencia-academica/spec.md`, Issue #1, `.stitch/DESIGN.md`, `.stitch/SITE.md`.

## Phase 1: Setup

- [ ] T001 Criar branch `feature/calculadora-sobrevivencia-academica` a partir de `master` no repo `Alexandria-UFSC`.
- [ ] T002 Criar monorepo npm minimo com app Next.js em `Alexandria-UFSC/apps/web`.
- [ ] T003 Configurar scripts root para `dev`, `build`, `lint`, `typecheck`, `test` e `test:e2e`.

## Phase 2: Foundational

- [ ] T004 Criar regras academicas puras em `apps/web/src/lib/academic.ts`.
- [ ] T005 Criar testes unitarios para media, proxima nota, REC, frequencia e validacoes.

## Phase 3: US1 - Simular sobrevivencia academica

- [ ] T006 Criar teste de componente para estrutura principal, calculo, mensagens e adicionar/remover avaliacao.
- [ ] T007 Implementar tela inicial com marca, navegacao futura, formulario, resultado e criterios UFSC.
- [ ] T008 Implementar E2E Playwright cobrindo os cenarios BDD principais e screenshots desktop/mobile.

## Phase 4: Evaluation

- [ ] T009 Criar `evaluation-contract.json` com sensores reais e evidencias visuais esperadas.
- [ ] T010 Atualizar `.harness/sensors.json` para rodar comandos reais contra `Alexandria-UFSC`.
- [ ] T011 Rodar `rtk bash scripts/validate.sh`.
- [ ] T012 Rodar `rtk bash scripts/evaluate.sh specs/calculadora-sobrevivencia-academica`.
- [ ] T013 Se avaliação passar, abrir PR para `master` e mover card para `In review`.

## Notes

- O Stitch MCP nao estava disponivel na sessao; fallback local registrado em `plan.md`.
- A US permanece limitada a uma historia e cinco blocos de implementacao.
