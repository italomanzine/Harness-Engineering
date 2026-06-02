# Workflow: Harness Engineering Demo

Este arquivo define a coreografia simples dos agentes para a palestra.

## Fluxo 1: `/refine`

### 1. Bootstrap e Recepção
- **Agente:** Orchestrator.
- **Ação:** Executar `scripts/bootstrap-context.sh`, identificar a ideia de feature e rotear para Product Manager.

### 2. Spec
- **Agente:** Product Manager.
- **Ação:** Entrevistar o usuário, reduzir ambiguidade e definir valor.
- **Backbone:** GitHub Spec Kit (`Spec -> Plan -> Tasks -> Implement`).
- **Saída:** Spec SDD em `specs/<slug>/spec.md`.
- **BDD:** Cada requisito deve ter cenário `Dado / Quando / Então`.

### 3. Backlog
- **Ferramenta:** GitHub MCP.
- **Ação:** Criar cards de User Story no GitHub Project.
- **Regra:** Cada card deve linkar a spec e conter critérios de aceite BDD.
- **Memória:** Atualizar `.memory/progress.md` e `.memory/session-context.json`.

## Fluxo 2: `/intent`

### 1. Bootstrap e Recepção
- **Agente:** Orchestrator.
- **Ação:** Executar `scripts/bootstrap-context.sh`, ler card/Issue via GitHub MCP e spec em `specs/<slug>/spec.md`.
- **Memória:** Salvar contexto em `.memory/session-context.json`.

### 2. Disciplina de Branch
- **Ação obrigatória:** Criar `feature/<slug>` a partir da `main`.
- **Bloqueio:** Nunca commitar direto em `main` ou `master`.

### 3. Planejamento Técnico
- **Agente:** Architect.
- **Ação:** Criar `specs/<slug>/plan.md`, `specs/<slug>/tasks.md` e `specs/<slug>/evaluation-contract.json`.
- **Skill auxiliar:** `.agents/skills/tlc-spec-driven/SKILL.md` para auto-sizing quando o escopo for grande, ambíguo ou brownfield.
- **Contrato:** Evaluator valida o contrato antes do Coder começar.

### 4. Desenvolvimento
- **Agente:** Coder.
- **Skills:** `.skills/tdd-logic.md`, `.skills/clean-code.md`.
- **Limite anti One Shot Hero:** Implementar no máximo 1 User Story ou 5 tasks por ciclo.
- **Loop TDD/BDD:**
  1. Criar/atualizar teste a partir de `REQ-*` e `SCN-*`.
  2. Implementar código.
  3. Refatorar sem alterar comportamento.
  4. Declarar `ready_for_evaluation`.
  5. Nunca emitir `PASS`.

### 5. Loop Visual com Stitch
- **Quando:** Mudanças de frontend.
- **Ferramentas:** Stitch MCP HTTP no servidor `stitch`, `.agents/skills/stitch-loop/SKILL.md`, `.agents/skills/design-md/SKILL.md`, `.agents/skills/enhance-prompt/SKILL.md`, `.agents/skills/ui-ux-pro-max/SKILL.md`.
- **Configuração:** `.mcp.json` deve conter `mcpServers.stitch.type=http`, `url=https://stitch.googleapis.com/mcp` e header `X-Goog-Api-Key`.
- **Browser principal:** `.agents/skills/playwright/SKILL.md` e Playwright MCP para jornadas, snapshots de DOM/acessibilidade e screenshots.
- **Diagnóstico:** `.agents/skills/chrome-devtools/SKILL.md` e Chrome DevTools MCP para console, rede, traces e DOM ao vivo quando Playwright não explicar a falha.
- **Meta:** Pelo menos 98% de similaridade visual com o design do Stitch.
- **UX Gate:** Verificar acessibilidade, touch targets, responsividade, hierarquia visual, tipografia, cores e estados de interação.
- **Evidência:** Screenshot antes/depois ou comparação visual anexada ao PR.

### 6. Avaliação Determinística
- **Agente:** Evaluator.
- **Ação:** Executar `scripts/evaluate.sh <feature-dir>`.
- **Gate:** Retorno `0` libera Reviewer; retorno `1` volta para Coder.
- **Memória:** Resultado gravado em `.memory/last-evaluation.json`.

### 7. Revisão
- **Agente:** Reviewer.
- **Ação:** Avaliar diff, spec, SDD/TDD/BDD, segurança, testes, drift e evidências visuais.
- **Regra:** Não aprovar se `.memory/last-evaluation.json` não estiver `PASS`.

### 8. Conclusão
- **Ferramenta:** GitHub MCP.
- **Ação:** Criar PR para `main`, postar resumo, linkar card/spec/contrato e anexar evidências.
- **Log:** Atualizar `.memory/progress.md` e `.memory/decision-log.md`.
