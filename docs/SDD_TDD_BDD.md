# SDD + TDD + BDD no Harness

Este harness combina três práticas:

- **SDD:** decide o que construir antes de codar.
- **BDD:** descreve comportamento em linguagem verificável.
- **TDD:** guia implementação com teste antes do código.

## Framework adotado

O backbone é o GitHub Spec Kit:

```text
Spec -> Plan -> Tasks -> Implement
```

No repositório, isso aparece como:

```text
specs/<slug>/
├── spec.md
├── plan.md
└── tasks.md
```

## Skill auxiliar

Use `.agents/skills/tlc-spec-driven/SKILL.md` quando a feature precisar de:

- auto-sizing de processo;
- mapeamento brownfield;
- memória entre sessões;
- divisão adaptativa de tasks;
- retomada após pausa.

## Como BDD entra na spec

Cada requisito deve ter pelo menos um cenário:

```gherkin
Dado que o usuário está autenticado
Quando ele acessa o dashboard
Então ele vê seus indicadores principais
```

## Como TDD entra na implementação

Cada task de implementação deve seguir:

```text
Red -> Green -> Refactor
```

1. Criar teste que falha.
2. Implementar o mínimo para passar.
3. Refatorar sem mudar comportamento.
4. Rodar `scripts/validate.sh`.

## Fluxo integrado

```text
/refine
  Product Manager
  spec.md com requisitos + cenários BDD
  cards no GitHub Project

/intent
  Architect
  plan.md com estratégia técnica e TDD
  tasks.md com rastreabilidade REQ/SCN
  Coder implementa Red -> Green -> Refactor
  Reviewer valida spec, testes, BDD, PR e Stitch
```
