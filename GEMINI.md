# GEMINI.md - Harness Engineering Orchestration

Este arquivo define como o Gemini CLI deve operar dentro do framework de **Harness Engineering**.

## 🚀 O Comando `/refine`
Sempre que o usuário iniciar uma solicitação com `/refine` ou pedir para refinar uma feature:

1. **Product Manager:** Use `.agents/roles/product_manager.md`.
2. **Spec Driven Development:** Use o backbone GitHub Spec Kit: `Spec -> Plan -> Tasks -> Implement`.
3. **Spec:** Crie `specs/<slug>/spec.md` usando `.specify/templates/spec-template.md`.
4. **BDD:** Registre critérios em `Dado / Quando / Então`.
5. **GitHub Project:** Use MCP GitHub para criar/atualizar cards de User Story.
6. **Sem Código:** Não implemente a feature durante `/refine`.

## 🚀 O Comando `/intent`
Sempre que o usuário iniciar uma solicitação com `/intent` ou pedir para resolver uma Issue/User Story:

1.  **Orquestração:** Siga rigorosamente o fluxo definido em `.harness/workflow.md`.
2.  **Contexto:** Utilize o **MCP GitHub** para extrair detalhes da tarefa se um link for fornecido.
3.  **Branch:** Nunca trabalhe em `main` ou `master`; crie `feature/<slug>` a partir da `main`.
4.  **Planejamento:** Crie/valide `specs/<slug>/plan.md`, `specs/<slug>/tasks.md` e `specs/<slug>/evaluation-contract.json`.
5.  **Contrato:** Invoque o Evaluator para validar o contrato antes do Coder começar.
6.  **TDD/BDD:** Implemente no máximo 1 User Story ou 5 tasks por ciclo com Red -> Green -> Refactor.
7.  **Avaliação:** Execute `scripts/evaluate.sh <feature-dir>`; só prossiga se retornar `0`.
8.  **PR:** Ao concluir, abra PR para `main` via MCP GitHub somente após `PASS`.

## 🧠 Agentes e Skills
- **Agentes:** Utilize as personas em `.agents/roles/` para guiar cada fase.
- **Skills:** Aplique os padrões de raciocínio em `.skills/`.
- **Spec Kit:** Use `.specify/constitution.md` e `.specify/templates/` como contratos do fluxo SDD.
- **TLC:** Use `.agents/skills/tlc-spec-driven/SKILL.md` como skill auxiliar para auto-sizing e memória.
- **Stitch:** Para frontend, use o Stitch MCP HTTP configurado como `stitch` em `.mcp.json`, `.agents/skills/stitch-loop/SKILL.md`, `.agents/skills/design-md/SKILL.md` e `.agents/skills/enhance-prompt/SKILL.md`.
- **UI/UX:** Para frontend, use `.agents/skills/ui-ux-pro-max/SKILL.md` para acessibilidade, responsividade, interação, tipografia, cores e hierarquia visual.
- **Browser:** Use `.agents/skills/playwright/SKILL.md` como ferramenta principal de navegador e `.agents/skills/chrome-devtools/SKILL.md` como diagnóstico complementar.
- **Evaluator:** Use `.agents/roles/evaluator.md` para validação binária por sensores.

## 📚 Pasta `docs/`
`docs/` contém apenas exemplos e material de inspiração para a palestra. Não use arquivos de `docs/` como dependência direta dos fluxos `/refine` ou `/intent`.

## 🛡️ O Harness (Validação Obrigatória)
**NENHUMA** alteração de código é considerada final sem passar pelo Harness.

- **Comando de Validação:** Execute sempre `scripts/validate.sh` (que por baixo usa `rtk`).
- **Comando de Avaliação:** Antes de PR, execute `scripts/evaluate.sh <feature-dir>`.
- **Falha no Harness:** Se a validação falhar, você deve:
    1. Analisar os logs de erro.
    2. Propor e aplicar a correção.
    3. Re-executar o Harness até obter sucesso (✅).

## 📖 Referências de Contexto
- **Contrato geral:** `AGENTS.md`
- **Workflow:** `.harness/workflow.md`
- **Spec Kit:** `.specify/memory/constitution.md`
- **Comandos RTK:** `CLAUDE.md`

---
*Este arquivo é o seu contrato de operação. Mantenha a integridade do "cercado" (Harness) acima de tudo.*
