# Skill: TDD (Test Driven Development) Logic

## Objetivo
Garantir que toda nova funcionalidade ou correção de bug seja coberta por testes antes da implementação final.

## Procedimento
1. **Red Stage:** Escreva um teste que falha para a nova funcionalidade.
2. **Green Stage:** Escreva o código mínimo necessário para fazer o teste passar.
3. **Refactor Stage:** Melhore o código mantendo o teste verde.

## Regras de Ouro
- Nunca escreva código de produção sem um teste falhando primeiro.
- O "Harness" de teste deve ser executado via `rtk test`.
