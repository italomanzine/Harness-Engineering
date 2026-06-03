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

## Targets Operacionais

Os destinos de GitHub, Kanban e Stitch ficam em `.harness/github-targets.json`. Para clones e workshops, comece copiando ou comparando com `.harness/github-targets.example.json` e substitua os placeholders pelos seus recursos próprios.

- **Repo de produto:** `productRepository`
- **Repo do harness:** `harnessRepository`
- **GitHub Project:** `projectUrl`
- **Stitch Project:** `defaultStitchProjectUrl`
- **Stitch resource:** `stitchProjectName`

Issues/User Stories e PRs de produto nunca devem ser criados no repo do harness. Em modo playground, use fork, repo próprio ou execução local; não use os recursos originais da palestra.

## Requisitos

Para usar o harness como playground, você precisa de:

- **Git:** clonar o repositório, criar branches e abrir PRs.
- **Bash:** executar os scripts em `scripts/`.
- **jq:** validar e ler arquivos JSON usados pelo bootstrap e pelos sensores.
- **Node.js e npx:** instalar skills e iniciar MCPs baseados em npm.
- **RTK:** executar comandos de forma compacta, especialmente validação, avaliação, Git e testes.
- **Agente/IDE compatível:** Codex/CLI de agente lendo `AGENTS.md`, GitHub Copilot com prompts/agentes em `.github/`, ou Gemini CLI lendo `GEMINI.md`.
- **Conta GitHub:** necessária para usar GitHub MCP com Issues, Project, branches e PRs.
- **Repo ou fork próprio:** necessário para usar `/refine` e `/intent` sem tocar nos recursos originais da palestra.
- **API key do Stitch:** necessária somente se você for usar Stitch MCP; use uma chave própria.
- **Navegador/Playwright:** necessário somente para validação visual, screenshots e jornadas browser.

Verifique as ferramentas locais:

```bash
git --version
bash --version
jq --version
node --version
npx --version
rtk --version
```

## Instalação das Dependências

Clone o repositório ou seu fork:

```bash
git clone <url-do-seu-fork-ou-repo>
cd Harness-Engineering
```

Crie a configuração local de MCP:

```bash
cp .mcp.example.json .mcp.json
```

Edite `.mcp.json` apenas na sua máquina. Substitua `X-Goog-Api-Key` pela sua chave real somente se for usar Stitch MCP. O arquivo `.mcp.json` é ignorado pelo Git e não deve ser versionado.

Instale as skills principais, se elas ainda não estiverem disponíveis no seu ambiente:

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

Configure os destinos do playground em `.harness/github-targets.json`:

```json
{
  "productRepository": "SEU_USUARIO/SEU_REPO_DE_PRODUTO",
  "harnessRepository": "SEU_USUARIO/Harness-Engineering",
  "projectUrl": "https://github.com/users/SEU_USUARIO/projects/NUMERO/views/1",
  "defaultStitchProjectUrl": "https://stitch.withgoogle.com/projects/SEU_STITCH_PROJECT_ID?pli=1",
  "stitchProjectName": "projects/SEU_STITCH_PROJECT_ID"
}
```

Configure sensores reais somente quando houver projeto alvo. Enquanto estiver no demo, o sensor `harness` já é suficiente:

```json
{
  "sensors": {
    "unit": {
      "command": "rtk npm --prefix caminho/do/app test"
    }
  }
}
```

Valide o playground:

```bash
rtk bash scripts/validate.sh
rtk bash scripts/evaluate.sh specs/demo-feature
```

## Modo Playground

O playground é o modo seguro para participantes clonarem o repositório, testarem melhorias e aprenderem o fluxo sem tocar nos recursos originais do facilitador.

Setup recomendado:

```bash
git clone <url-do-seu-fork-ou-repo>
cd Harness-Engineering
cp .mcp.example.json .mcp.json
rtk bash scripts/validate.sh
rtk bash scripts/evaluate.sh specs/demo-feature
```

Depois do clone:

1. Edite `.harness/github-targets.json` com seu `productRepository`, `harnessRepository`, `projectUrl`, `defaultStitchProjectUrl` e `stitchProjectName`.
2. Edite `.mcp.json` somente na sua máquina e coloque suas credenciais locais. Nunca versione `.mcp.json`.
3. Ajuste `.harness/sensors.json` para apontar para os comandos reais do seu app alvo quando sair do demo.
4. Use `specs/demo-feature` como primeiro exercício. Para features novas, crie uma pasta em `specs/<slug>/`.
5. Use `.stitch/` como referência visual read-only ou substitua por arquivos exportados do seu próprio Stitch.

O diretório `Alexandria-UFSC/` foi usado como produto exemplo durante a palestra e está ignorado por padrão. Quem clona o harness deve criar, clonar ou apontar o próprio projeto alvo e então preencher os sensores correspondentes.

## O Que Alterar Após Clonar

- `.harness/github-targets.json`: substitua os placeholders por recursos seus. O `productRepository` recebe Issues/PRs de produto; o `harnessRepository` é apenas o repo do harness.
- `.mcp.json`: copie de `.mcp.example.json` e configure chaves locais. O arquivo real fica fora do Git.
- `.harness/sensors.json`: mantenha apenas sensores com comandos executáveis no seu ambiente. Sensores vazios falham se forem listados em `evaluation-contract.json`.
- `specs/`: preserve `specs/demo-feature` para validar o harness e crie specs próprias para exercícios.
- `.stitch/`: trate como referência versionada. Se quiser editar design, crie seu próprio projeto Stitch e atualize os targets.

## Stitch Com Segurança

Não compartilhe uma API key com acesso de escrita ao projeto Stitch original. A pasta `.stitch/` deve funcionar como referência local: `DESIGN.md`, `SITE.md` e prompts descrevem o design esperado sem exigir que participantes editem o recurso remoto.

Para exercícios com MCP Stitch, cada participante deve usar uma API key própria e um Stitch Project próprio ou copiado. Se um projeto remoto compartilhado for indispensável, use uma conta/gateway controlado e bloqueie ferramentas MCP de escrita quando possível. A regra prática do harness é simples: projeto compartilhado é referência; edição acontece em projeto próprio.

## Modo Operacional da Palestra

Os recursos reais usados na palestra foram:

- **Repo de produto:** `italomanzine/Alexandria-UFSC`
- **Repo do harness:** `italomanzine/Harness-Engineering`
- **GitHub Project:** `https://github.com/users/italomanzine/projects/3/views/1`
- **Stitch Project:** `https://stitch.withgoogle.com/projects/13111711788255953460?pli=1`
- **Stitch resource:** `projects/13111711788255953460`

Esses valores são um perfil do facilitador, não o padrão seguro para clones públicos. Use-os apenas quando você controlar as credenciais, o Project e o repositório de produto.

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
- **Stitch MCP:** leitura de protótipos, telas e evidências visuais via servidor HTTP `stitch` em `https://stitch.googleapis.com/mcp`.
- **Playwright MCP:** navegação, manipulação de UI, snapshots e screenshots.
- **Chrome DevTools MCP:** diagnóstico complementar para console, rede, DOM e performance.

`.mcp.json` é configuração local e não deve ser versionado.
No `.mcp.json`, substitua o placeholder `X-Goog-Api-Key` pela chave real. Não coloque segredos em `.mcp.example.json`.

Setup por servidor:

- **GitHub MCP:** autentique o conector GitHub no ambiente do seu agente. Use apenas o `productRepository` e o `projectUrl` definidos em `.harness/github-targets.json`; nunca crie Issues/PRs de produto no `harnessRepository`.
- **Stitch MCP:** em `.mcp.json`, mantenha `mcpServers.stitch.type=http`, `url=https://stitch.googleapis.com/mcp` e preencha `headers.X-Goog-Api-Key` com sua chave local. Em playground, use um Stitch Project próprio e trate `.stitch/` como referência read-only.
- **Playwright MCP:** o exemplo já usa `npx -y @playwright/mcp@latest --caps=vision,pdf,devtools`. Use para jornadas, acessibilidade, screenshots e evidências visuais.
- **Chrome DevTools MCP:** o exemplo já usa `npx -y chrome-devtools-mcp@latest --isolated=true --viewport=1920x1080`. Use como diagnóstico complementar para console, rede, DOM e performance.

Exemplo resumido de `.mcp.json` local:

```json
{
  "mcpServers": {
    "stitch": {
      "type": "http",
      "url": "https://stitch.googleapis.com/mcp",
      "headers": {
        "X-Goog-Api-Key": "SUA_CHAVE_LOCAL"
      }
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest", "--caps=vision,pdf,devtools"]
    },
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest", "--isolated=true", "--viewport=1920x1080"]
    }
  }
}
```

## Como Usar por Ferramenta

### Codex ou CLI de agente

1. Abra o repositório no agente.
2. Garanta que o agente leu `AGENTS.md`.
3. Configure `.harness/github-targets.json` e `.mcp.json`.
4. Use `/refine` para transformar uma ideia em spec e backlog.
5. Use `/intent` para implementar uma User Story em `Ready`.
6. Rode `rtk bash scripts/validate.sh` e `rtk bash scripts/evaluate.sh specs/<slug>`.

### GitHub Copilot e Spec Kit

1. Use os prompts `.github/prompts/refine.prompt.md` e `.github/prompts/intent.prompt.md`.
2. Use os agentes em `.github/agents/` quando o ambiente suportar agentes customizados.
3. Mantenha `.github/copilot-instructions.md` como contrato de contexto.
4. Para comandos Spec Kit puros, use os prompts `speckit.*` em `.github/prompts/`.

### Gemini CLI

1. Abra o repositório com Gemini CLI.
2. Use `GEMINI.md` como contrato operacional.
3. Execute `/refine` para especificação e `/intent` para implementação.
4. Antes de encerrar, rode `rtk bash scripts/validate.sh` e `rtk bash scripts/evaluate.sh specs/<slug>`.

### GitHub MCP

1. Autentique a conta GitHub no ambiente do agente.
2. Confirme que `.harness/github-targets.json` aponta para seu repo/fork.
3. Em `/refine`, crie Issues/User Stories no `productRepository` e adicione ao `projectUrl`.
4. Em `/intent`, leia apenas cards `Ready`, mova para `In progress`, crie branch `feature/<slug>` e abra PR após `PASS`.
5. Após abrir PR, mova o card para `In review`.

### Stitch MCP

1. Configure sua API key no `.mcp.json` local.
2. Use `defaultStitchProjectUrl` e `stitchProjectName` do seu próprio projeto Stitch.
3. Use `.stitch/DESIGN.md` como referência visual do harness.
4. Não edite projeto Stitch compartilhado; gere ou altere telas apenas no seu projeto.
5. Registre screenshots/evidências quando `visualEvidenceRequired=true`.

### Playwright MCP

1. Use o servidor `playwright` configurado em `.mcp.json`.
2. Execute jornadas BDD de interface.
3. Colete snapshots de DOM/acessibilidade.
4. Capture screenshots desktop/mobile.
5. Liste os arquivos em `visualEvidence` quando o contrato exigir evidência visual.

### Chrome DevTools MCP

1. Use somente quando Playwright não explicar o problema.
2. Inspecione console, rede, performance e DOM ao vivo.
3. Use os achados para corrigir a implementação ou documentar bloqueios.
4. Não trate Chrome DevTools como gate primário; o gate continua sendo `scripts/evaluate.sh`.

### RTK

Use `rtk` como prefixo padrão para comandos:

```bash
rtk git status
rtk bash scripts/validate.sh
rtk bash scripts/evaluate.sh specs/demo-feature
rtk npm test
rtk npm run build
```

### Sensores do Harness

1. Declare sensores em `.harness/sensors.json`.
2. Liste no `evaluation-contract.json` apenas sensores com comando real.
3. Deixe sensores vazios fora de `checks`; sensores vazios falham por design.
4. Use `harness` para validar o playground mínimo.
5. Use `unit`, `lint`, `typecheck`, `build`, `e2e` e `visual` quando o app alvo tiver comandos correspondentes.

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
2. Orchestrator lê `.harness/github-targets.json`.
3. Product Manager refina a ideia, reduz ambiguidades e define valor.
4. Product Manager cria `specs/<slug>/spec.md`.
5. A spec registra requisitos, critérios de aceite e cenários BDD.
6. GitHub MCP cria ou atualiza Issues/User Stories no `productRepository`.
7. Cada Issue é adicionada ao `projectUrl`.
8. Cards novos recebem `Status=Backlog`.
9. Se houver UI, o card inclui Stitch Project, resource MCP, `.stitch/DESIGN.md`, diretrizes UI/UX, meta de 98% e evidência visual obrigatória no PR.
10. O ciclo atualiza `.memory/progress.md` e `.memory/session-context.json`.

Saída esperada:

- `specs/<slug>/spec.md`
- User Stories no `productRepository`
- cards no `projectUrl` com `Status=Backlog`
- critérios BDD por User Story
- referência Stitch/UI quando houver interface
- contexto atualizado em `.memory/`

## Fluxo `/intent`

Use `/intent` para implementar uma User Story específica.

1. Orchestrator executa `scripts/bootstrap-context.sh`.
2. Orchestrator lê `.harness/github-targets.json`.
3. Orchestrator lê card/Issue no `productRepository` via GitHub MCP e a spec correspondente.
4. O card deve estar no `projectUrl` com `Status=Ready`; caso contrário, o fluxo para.
5. Ao iniciar, o card é movido para `In progress`.
6. O fluxo cria `feature/<slug>` a partir da `main` no repo de produto.
7. Architect cria `plan.md`, `tasks.md` e `evaluation-contract.json`.
8. Evaluator valida o contrato antes do Coder começar.
9. Coder implementa no máximo 1 User Story ou 5 tasks por ciclo.
10. Coder segue TDD e mapeia cenários BDD para testes ou evidências.
11. Coder declara `ready_for_evaluation`.
12. Evaluator executa `scripts/evaluate.sh <feature-dir>`.
13. Reviewer revisa somente após `PASS`.
14. GitHub MCP cria PR para `main` no `productRepository` com links, resumo e evidências.
15. Após PR aberto, o card é movido para `In review`.

O PR só pode ser aberto quando `scripts/evaluate.sh <feature-dir>` retornar `0`.
O card não é movido automaticamente para concluído; a validação humana decide o próximo status.

## Kanban

- `/refine` cria cards em `Backlog`.
- Um humano ou processo externo move cards para `Ready`.
- `/intent` só puxa cards em `Ready`.
- `/intent` move o card para `In progress` ao iniciar implementação.
- `/intent` move o card para `In review` após abrir o PR.
- Nenhum agente move card automaticamente para concluído.

## UI/UX

Para mudanças visuais ou interativas:

- Use Stitch MCP como referência visual. O servidor esperado no MCP local é `stitch`.
- Use o `defaultStitchProjectUrl`.
- Use o resource MCP `stitchProjectName`.
- Use `.stitch/DESIGN.md` como fonte visual operacional real.
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
.harness/github-targets.json
.harness/github-targets.example.json
.harness/sensors.json      Sensores determinísticos
.harness/browser-validation.md
.memory/                   Estado, progresso e avaliação
.mcp.example.json          Exemplo de configuração MCP versionável
.specify/                  Spec Kit, templates e constituição
.stitch/                   Contexto versionado/read-only do protótipo Stitch
specs/                     Specs, planos, tasks e contratos
scripts/                   Bootstrap, validação e avaliação
```

`docs/` é somente material de exemplo e inspiração. O harness não deve depender diretamente de arquivos dentro dessa pasta para executar `/refine`, `/intent`, avaliação, revisão ou PR.

## Regras Obrigatórias

- Nunca commitar direto em `main` ou `master`.
- Issues/User Stories e PRs de produto devem usar o `productRepository`.
- `/refine` cria cards novos em `Backlog`.
- `/intent` só inicia cards em `Ready`.
- `/intent` move cards para `In progress` ao iniciar e `In review` após PR.
- Toda implementação de `/intent` deve usar branch `feature/<slug>`.
- Toda feature deve ter spec antes de implementação.
- Todo plano deve mapear requisitos e cenários BDD para testes ou evidências.
- Toda feature deve ter `evaluation-contract.json`.
- Coder nunca emite `PASS`.
- Evaluator nunca implementa.
- Reviewer não aprova sem `PASS` em `.memory/last-evaluation.json`.
- PR só abre após `scripts/evaluate.sh <feature-dir>` retornar `0`.
- Mudanças de UI exigem `.stitch/DESIGN.md`, referência ao Stitch configurado e evidência visual quando marcadas no contrato.
- Fontes operacionais não devem depender diretamente de arquivos dentro de `docs/`.

## Uso Otimizado

1. Clone o repositório ou seu fork.
2. Verifique requisitos com `git --version`, `node --version`, `npx --version`, `jq --version` e `rtk --version`.
3. Copie `.mcp.example.json` para `.mcp.json` e configure apenas credenciais locais.
4. Crie ou selecione um repo/fork de produto.
5. Configure `.harness/github-targets.json` com `productRepository`, `harnessRepository`, `projectUrl`, `defaultStitchProjectUrl` e `stitchProjectName`.
6. Configure `.harness/sensors.json` com comandos reais do app alvo.
7. Rode `rtk bash scripts/validate.sh`.
8. Rode `rtk bash scripts/evaluate.sh specs/demo-feature` para validar o playground.
9. Execute `/refine` para criar spec e cards `Backlog`.
10. Mova manualmente o card aprovado para `Ready`.
11. Execute `/intent` para desenvolver uma User Story `Ready` por vez.
12. Execute `rtk bash scripts/bootstrap-context.sh specs/<slug>` no início de ciclos longos.
13. Execute `rtk bash scripts/evaluate.sh specs/<slug>` antes de revisão e PR.
14. Abra PR somente após avaliação `PASS`.
15. Anexe evidências visuais ao PR sempre que houver mudança de frontend.
