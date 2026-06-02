# Harness Constitution

Este projeto usa GitHub Spec Kit como backbone conceitual de SDD:

```text
Spec -> Plan -> Tasks -> Implement
```

O `tlc-spec-driven` é usado como skill auxiliar para auto-sizing, memória, mapeamento brownfield e execução adaptativa.

## Princípios

1. **Spec antes do código**
   - Toda feature nasce em `specs/<slug>/spec.md`.
   - A spec descreve comportamento observável, não solução técnica prematura.

2. **BDD para comportamento**
   - Critérios de aceite devem usar `Dado / Quando / Então`.
   - Cada cenário BDD deve mapear para pelo menos um teste automatizado, teste E2E ou evidência manual justificada.

3. **TDD para implementação**
   - Antes de código de produção, escreva ou atualize teste que prove o comportamento.
   - O ciclo esperado é Red -> Green -> Refactor.

4. **Plano técnico explícito**
   - Antes de implementar, crie `specs/<slug>/plan.md`.
   - O plano deve listar arquivos prováveis, decisões, riscos e estratégia de testes.

5. **Tasks rastreáveis**
   - Crie `specs/<slug>/tasks.md`.
   - Cada task deve apontar para requisitos, cenários BDD e verificação.

6. **Branch discipline**
   - Nunca trabalhar direto em `main` ou `master`.
   - `/intent` sempre cria `feature/<slug>` a partir da `main`.

7. **Visual fidelity**
   - Para frontend, usar Stitch MCP e evidência visual no PR.
   - Meta: pelo menos 98% de similaridade visual com o protótipo.

8. **PR como trilha de auditoria**
   - Todo PR deve linkar card/Issue, spec, plan, tasks e evidências.
   - O Reviewer bloqueia drift, falta de teste, desvio de spec e baixa fidelidade visual.
