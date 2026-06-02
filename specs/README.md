# Specs SDD

Este diretório guarda as specs criadas pelo fluxo `/refine`.

Cada arquivo deve:
- Usar `.specify/templates/spec-template.md`.
- Ter um slug estável, por exemplo `specs/login-social/spec.md`.
- Ser linkado nos cards de User Story do GitHub Project.
- Servir como contrato para o fluxo `/intent`.

## Estrutura por feature

```text
specs/<slug>/
├── spec.md   # O que construir, requisitos e cenários BDD
├── plan.md   # Como construir, decisões técnicas e estratégia TDD
└── tasks.md  # Tasks atômicas, rastreabilidade e verificação
```

## Backbone

Use o fluxo do GitHub Spec Kit:

```text
Spec -> Plan -> Tasks -> Implement
```
