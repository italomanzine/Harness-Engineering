# Workflow: Harness Engineering

Este arquivo define a coreografia operacional dos agentes.

## Fluxo 1: `/refine`

### 1. Bootstrap e Recepção
- **Agente:** Orchestrator.
- **Ação:** Executar `scripts/bootstrap-context.sh`, identificar a ideia de feature e rotear para Product Manager.
- **Targets:** Ler `.harness/github-targets.json` antes de criar Issues, cards ou referências de design.

### 2. Spec
- **Agente:** Product Manager.
- **Ação:** Entrevistar o usuário, reduzir ambiguidade e definir valor.
- **Backbone:** GitHub Spec Kit (`Spec -> Plan -> Tasks -> Implement`).
- **Saída:** Spec SDD em `specs/<slug>/spec.md`.
- **BDD:** Cada requisito deve ter cenário `Dado / Quando / Então`.

### 3. Backlog
- **Ferramenta:** GitHub MCP.
- **Repositório:** Criar Issues/User Stories somente em `italomanzine/Alexandria-UFSC`.
- **Projeto:** Adicionar cada Issue ao Project `https://github.com/users/italomanzine/projects/3/views/1`.
- **Kanban:** Definir `Status=Backlog` para cards novos.
- **Regra:** Cada card deve linkar a spec, conter critérios de aceite BDD, target de implementação e, se houver UI, link Stitch, resource Stitch, `.stitch/DESIGN.md`, meta de 98% de similaridade e evidência visual obrigatória no PR.
- **Bloqueio:** Nunca criar Issues/User Stories de produto em `italomanzine/Harness-Engineering`.
- **Memória:** Atualizar `.memory/progress.md` e `.memory/session-context.json`.

## Fluxo 2: `/intent`

### 1. Bootstrap e Recepção
- **Agente:** Orchestrator.
- **Ação:** Executar `scripts/bootstrap-context.sh`, ler card/Issue via GitHub MCP e spec em `specs/<slug>/spec.md`.
- **Targets:** Ler `.harness/github-targets.json`.
- **Memória:** Salvar contexto em `.memory/session-context.json`.

### 2. Ready Gate e Kanban
- **Repositório:** A Issue/card deve pertencer a `italomanzine/Alexandria-UFSC`.
- **Projeto:** A Issue/card deve estar no Project `https://github.com/users/italomanzine/projects/3/views/1`.
- **Gate:** `/intent` só pode iniciar se o campo `Status` estiver em `Ready`.
- **Bloqueio:** Se o status for `Backlog`, `In progress`, `In review` ou qualquer outro, parar o fluxo e explicar o motivo.
- **Transição:** Ao iniciar desenvolvimento, mover o card para `In progress`.

### 3. Disciplina de Branch
- **Ação obrigatória:** Criar `feature/<slug>` a partir da `main`.
- **Bloqueio:** Nunca commitar direto em `main` ou `master`.
- **Repositório:** Branch e PR devem ser criados em `italomanzine/Alexandria-UFSC`, não no repo do harness.

### 4. Planejamento Técnico
- **Agente:** Architect.
- **Ação:** Criar `specs/<slug>/plan.md`, `specs/<slug>/tasks.md` e `specs/<slug>/evaluation-contract.json`.
- **Skill auxiliar:** `.agents/skills/tlc-spec-driven/SKILL.md` para auto-sizing quando o escopo for grande, ambíguo ou brownfield.
- **Contrato:** Evaluator valida o contrato antes do Coder começar.

### 5. Desenvolvimento
- **Agente:** Coder.
- **Skills:** `.skills/tdd-logic.md`, `.skills/clean-code.md`.
- **Limite anti One Shot Hero:** Implementar no máximo 1 User Story ou 5 tasks por ciclo.
- **Loop TDD/BDD:**
  1. Criar/atualizar teste a partir de `REQ-*` e `SCN-*`.
  2. Implementar código.
  3. Refatorar sem alterar comportamento.
  4. Declarar `ready_for_evaluation`.
  5. Nunca emitir `PASS`.

### 6. Loop Visual com Stitch
- **Quando:** Mudanças de frontend.
- **Ferramentas:** Stitch MCP HTTP no servidor `stitch`, `.agents/skills/stitch-loop/SKILL.md`, `.agents/skills/design-md/SKILL.md`, `.agents/skills/enhance-prompt/SKILL.md`, `.agents/skills/ui-ux-pro-max/SKILL.md`.
- **Configuração:** `.mcp.json` deve conter `mcpServers.stitch.type=http`, `url=https://stitch.googleapis.com/mcp` e header `X-Goog-Api-Key`.
- **Protótipo:** Usar `https://stitch.withgoogle.com/projects/13111711788255953460?pli=1` e resource MCP `projects/13111711788255953460`.
- **Fonte visual:** Usar `.stitch/DESIGN.md` como referência operacional real, não como exemplo.
- **Browser principal:** `.agents/skills/playwright/SKILL.md` e Playwright MCP para jornadas, snapshots de DOM/acessibilidade e screenshots.
- **Diagnóstico:** `.agents/skills/chrome-devtools/SKILL.md` e Chrome DevTools MCP para console, rede, traces e DOM ao vivo quando Playwright não explicar a falha.
- **Meta:** Pelo menos 98% de similaridade visual com o design do Stitch.
- **UX Gate:** Verificar acessibilidade, touch targets, responsividade, hierarquia visual, tipografia, cores e estados de interação.
- **Evidência:** Screenshot antes/depois ou comparação visual anexada ao PR.

### 7. Avaliação Determinística
- **Agente:** Evaluator.
- **Ação:** Executar `scripts/evaluate.sh <feature-dir>`.
- **Gate:** Retorno `0` libera Reviewer; retorno `1` volta para Coder.
- **Memória:** Resultado gravado em `.memory/last-evaluation.json`.

### 8. Revisão
- **Agente:** Reviewer.
- **Ação:** Avaliar diff, spec, SDD/TDD/BDD, segurança, testes, drift e evidências visuais.
- **Regra:** Não aprovar se `.memory/last-evaluation.json` não estiver `PASS`.

### 9. Conclusão
- **Ferramenta:** GitHub MCP.
- **Ação:** Criar PR para `main` em `italomanzine/Alexandria-UFSC`, postar resumo, linkar card/spec/contrato e anexar evidências.
- **Kanban:** Após PR aberto, mover o card para `In review`.
- **Validação humana:** Não mover automaticamente para concluído.
- **Log:** Atualizar `.memory/progress.md` e `.memory/decision-log.md`.
