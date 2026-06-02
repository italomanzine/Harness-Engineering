# Harness Engineering

Este repositório define um harness operacional para orientar agentes de IA em um fluxo controlado de desenvolvimento de software.

O harness não tenta substituir engenharia por automação cega. Ele cria um ambiente com instruções, papéis, contratos, memória e sensores externos para que agentes trabalhem com limites claros, validação real e rastreabilidade.

## Visão Rápida

```text
Ideia -> /refine -> Spec -> User Stories -> /intent -> Plan -> Tasks -> Contract -> TDD/BDD -> Evaluation -> Review -> PR
```

O backbone é o GitHub Spec Kit:

```text
Spec -> Plan -> Tasks -> Implement
```

Os artefatos de cada feature ficam em:

```text
specs/<slug>/
├── spec.md
├── plan.md
├── tasks.md
└── evaluation-contract.json
```

## Princípios

- **SDD:** toda feature começa com uma spec antes de código.
- **BDD:** requisitos são descritos com cenários `Dado / Quando / Então`.
- **TDD:** implementação segue Red -> Green -> Refactor.
- **Contratos:** cada feature tem um `evaluation-contract.json` validado antes da implementação.
- **Sensores determinísticos:** qualidade é verificada por comandos externos, não pela opinião do modelo.
- **Memória:** cada ciclo lê e atualiza contexto em `.memory/`.
- **Branch discipline:** nenhuma implementação acontece direto em `main` ou `master`.
- **UI/UX validável:** mudanças visuais usam Stitch, `ui-ux-pro-max` e Playwright.

## Problemas Que o Harness Previne

- **One Shot Hero:** `/intent` implementa no máximo 1 User Story ou 5 tasks por ciclo.
- **Vitória prematura:** Coder declara apenas `ready_for_evaluation`; só Evaluator pode emitir `PASS`.
- **Amnésia entre sessões:** `scripts/bootstrap-context.sh` e `.memory/` preservam contexto operacional.
- **Falta de validação real:** `scripts/evaluate.sh` executa sensores externos e retorna `0` ou `1`.
- **Drift acumulado:** Reviewer e Evaluator bloqueiam desvio de spec, arquitetura, testes e evidências.

## Agentes

- **Product Manager:** refina a ideia, cria a spec SDD e gera User Stories.
- **Orchestrator:** coordena os estados do harness e delega para os agentes corretos.
- **Architect:** transforma spec em plano técnico, tasks e contrato de avaliação.
- **Coder:** implementa a User Story com TDD, BDD e padrões do projeto.
- **Evaluator:** valida contrato e executa sensores determinísticos; nunca implementa.
- **Reviewer:** revisa diff, segurança, drift, aderência à spec, PR e evidências.

Os papéis ficam em `.agents/roles/`.

## Skills

Skills locais:

- `.skills/tdd-logic.md`: disciplina TDD para criação e evolução de testes.
- `.skills/clean-code.md`: padrões de implementação limpa e simples.

Skills instaladas:

- `.agents/skills/stitch-loop/SKILL.md`: loop de frontend com Stitch e verificação visual.
- `.agents/skills/design-md/SKILL.md`: geração de `.stitch/DESIGN.md` a partir do Stitch.
- `.agents/skills/enhance-prompt/SKILL.md`: melhoria de prompts visuais antes do Stitch.
- `.agents/skills/ui-ux-pro-max/SKILL.md`: análise de UI/UX, acessibilidade, layout e responsividade.
- `.agents/skills/playwright/SKILL.md`: automação browser, snapshots, DOM e screenshots.
- `.agents/skills/chrome-devtools/SKILL.md`: diagnóstico complementar de console, rede, DOM e performance.
- `.agents/skills/review-diff/SKILL.md`: revisão estruturada de diff.
- `.agents/skills/subagent-driven-development/SKILL.md`: coordenação de subagentes e revisão de qualidade.
- `.agents/skills/tlc-spec-driven/SKILL.md`: apoio para auto-sizing, memória, brownfield e retomada.
- `.agents/skills/speckit-agent-context-update/SKILL.md`: atualização de contexto de agente para Spec Kit.

Instalação das skills principais:

```bash
npx skills add https://github.com/google-labs-code/stitch-skills --skill stitch-loop
npx skills add https://github.com/google-labs-code/stitch-skills --skill design-md
npx skills add https://github.com/google-labs-code/stitch-skills --skill enhance-prompt
npx skills add https://github.com/nextlevelbuilder/ui-ux-pro-max-skill --skill ui-ux-pro-max
npx skills add https://github.com/openai/skills --skill playwright
npx skills add https://github.com/chromedevtools/chrome-devtools-mcp --skill chrome-devtools
npx skills add https://github.com/nesnilnehc/ai-cortex --skill review-diff
npx skills add https://github.com/obra/superpowers --skill subagent-driven-development
npx skills add https://github.com/tech-leads-club/agent-skills --skill tlc-spec-driven
```

## MCPs

Configure os MCPs a partir de `.mcp.example.json`.

- **GitHub MCP:** Issues, Projects, branches, PRs, comentários e anexos.
- **Stitch MCP:** leitura de protótipos, telas e evidências visuais.
- **Playwright MCP:** navegação, manipulação de UI, snapshots e screenshots.
- **Chrome DevTools MCP:** diagnóstico complementar para console, rede, DOM e performance.

`.mcp.json` é configuração local e não deve ser versionado.

## Sensores

`.harness/sensors.json` define os sensores disponíveis. O contrato da feature escolhe quais sensores serão executados.

Sensores atuais:

- `harness`: valida a integridade operacional do harness.
- `unit`: placeholder para testes unitários do projeto alvo.
- `integration`: placeholder para testes de integração.
- `e2e`: placeholder para testes ponta a ponta.
- `lint`: placeholder para lint.
- `typecheck`: placeholder para typecheck.
- `visual`: placeholder para comparação visual e evidências Stitch.
- `browser-evidence`: placeholder para validação browser automatizada.
- `chrome-diagnostics`: placeholder para diagnóstico Chrome DevTools.

Em um projeto real, substitua os comandos vazios por comandos concretos de lint, teste, build, E2E e validação visual.

## Fluxo `/refine`

Use `/refine` para transformar uma ideia em spec e backlog.

1. Orchestrator executa `scripts/bootstrap-context.sh`.
2. Product Manager refina a ideia, reduz ambiguidades e define valor.
3. Product Manager cria `specs/<slug>/spec.md`.
4. A spec registra requisitos, critérios de aceite e cenários BDD.
5. GitHub MCP cria ou atualiza cards de User Story.
6. O ciclo atualiza `.memory/progress.md` e `.memory/session-context.json`.

Saída esperada:

- `specs/<slug>/spec.md`
- User Stories no GitHub Project/Issues
- critérios BDD por User Story
- contexto atualizado em `.memory/`

## Fluxo `/intent`

Use `/intent` para implementar uma User Story específica.

1. Orchestrator executa `scripts/bootstrap-context.sh`.
2. Orchestrator lê card/Issue via GitHub MCP e a spec correspondente.
3. O fluxo cria `feature/<slug>` a partir da `main`.
4. Architect cria `plan.md`, `tasks.md` e `evaluation-contract.json`.
5. Evaluator valida o contrato antes do Coder começar.
6. Coder implementa no máximo 1 User Story ou 5 tasks por ciclo.
7. Coder segue TDD e mapeia cenários BDD para testes ou evidências.
8. Coder declara `ready_for_evaluation`.
9. Evaluator executa `scripts/evaluate.sh <feature-dir>`.
10. Reviewer revisa somente após `PASS`.
11. GitHub MCP cria PR para `main` com links, resumo e evidências.

O PR só pode ser aberto quando `scripts/evaluate.sh <feature-dir>` retornar `0`.

## UI/UX

Para mudanças visuais ou interativas:

- Use Stitch MCP como referência visual.
- Use `ui-ux-pro-max` para avaliar layout, hierarquia, acessibilidade, tipografia, cores, responsividade e interação.
- Use Playwright como ferramenta principal para abrir navegador, manipular UI, coletar snapshots e capturar screenshots.
- Use Chrome DevTools apenas como diagnóstico complementar.
- Registre evidências visuais no contrato da feature quando `visualEvidenceRequired=true`.

A meta visual para frontend é pelo menos 98% de similaridade com o design de referência.

## Memória Operacional

Arquivos em `.memory/` preservam contexto entre ciclos:

- `session-context.json`: contexto ativo do ciclo.
- `progress.md`: progresso e handoff entre sessões.
- `decision-log.md`: decisões relevantes.
- `last-evaluation.json`: último resultado do Evaluator.
- `project-index.md`: índice operacional do projeto.

Comece ciclos longos com:

```bash
rtk bash scripts/bootstrap-context.sh
```

Para uma feature específica:

```bash
rtk bash scripts/bootstrap-context.sh specs/<slug>
```

## Validação

Valide a integridade do harness:

```bash
rtk bash scripts/validate.sh
```

Valide uma feature antes de revisão e PR:

```bash
rtk bash scripts/evaluate.sh specs/<slug>
```

`scripts/evaluate.sh` exige que `evaluation-contract.json` contenha:

- `featureDir`
- `branch`
- `scope`
- `requirements`
- `bddScenarios`
- `checks`
- `visualEvidenceRequired`
- `maxCycles`

Se `visualEvidenceRequired=true`, o contrato também deve listar evidências existentes em `visualEvidence`.

## Estrutura Operacional

```text
AGENTS.md                  Contrato operacional principal
GEMINI.md                  Instruções compatíveis com Gemini
.github/copilot-instructions.md
.github/agents/            Agentes do Spec Kit para Copilot
.github/prompts/           Prompts do Spec Kit para Copilot
.agents/roles/             Papéis dos agentes do harness
.agents/skills/            Skills instaladas
.skills/                   Skills locais simples
.harness/workflow.md       Coreografia dos fluxos
.harness/sensors.json      Sensores determinísticos
.harness/browser-validation.md
.memory/                   Estado, progresso e avaliação
.mcp.example.json          Exemplo de configuração MCP versionável
.specify/                  Spec Kit, templates e constituição
.stitch/                   Contexto de design Stitch
specs/                     Specs, planos, tasks e contratos
scripts/                   Bootstrap, validação e avaliação
```

`docs/` é somente material de exemplo e inspiração. O harness não deve depender diretamente de arquivos dentro dessa pasta para executar `/refine`, `/intent`, avaliação, revisão ou PR.

## Regras Obrigatórias

- Nunca commitar direto em `main` ou `master`.
- Toda implementação de `/intent` deve usar branch `feature/<slug>`.
- Toda feature deve ter spec antes de implementação.
- Todo plano deve mapear requisitos e cenários BDD para testes ou evidências.
- Toda feature deve ter `evaluation-contract.json`.
- Coder nunca emite `PASS`.
- Evaluator nunca implementa.
- Reviewer não aprova sem `PASS` em `.memory/last-evaluation.json`.
- PR só abre após `scripts/evaluate.sh <feature-dir>` retornar `0`.
- Mudanças de UI exigem evidência visual quando marcadas no contrato.
- Fontes operacionais não devem depender diretamente de arquivos dentro de `docs/`.

## Uso Otimizado

1. Configure os MCPs copiando `.mcp.example.json` para `.mcp.json` e ajustando o necessário localmente.
2. Atualize `.harness/sensors.json` com comandos reais do projeto que usará o harness.
3. Use `/refine` para criar spec e cards antes de implementar.
4. Use `/intent` para desenvolver uma User Story por vez.
5. Execute bootstrap no início de ciclos longos.
6. Execute `rtk bash scripts/validate.sh` antes de considerar o harness saudável.
7. Execute `rtk bash scripts/evaluate.sh specs/<slug>` antes de revisão e PR.
8. Anexe evidências visuais ao PR sempre que houver mudança de frontend.
