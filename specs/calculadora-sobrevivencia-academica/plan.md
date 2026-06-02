# Implementation Plan: Calculadora de Sobrevivencia Academica

**Branch**: `feature/calculadora-sobrevivencia-academica` | **Date**: 2026-06-02 | **Spec**: `specs/calculadora-sobrevivencia-academica/spec.md`

**Input**: GitHub Issue #1 em `italomanzine/Alexandria-UFSC`.

## Summary

Implementar uma tela inicial funcional em React/Next.js para estudantes da UFSC simularem media parcial, nota necessaria na proxima avaliacao, frequencia e recuperacao. A entrega usa um monorepo npm minimo no repo de produto `Alexandria-UFSC`, com app isolado em `apps/web`, testes unitarios/componentes/E2E e evidencia visual Playwright.

## Technical Context

**Language/Version**: TypeScript, React, Next.js App Router.

**Primary Dependencies**: Next.js, React, Vitest, Testing Library, Playwright.

**Storage**: N/A; sem persistencia entre sessoes.

**Testing**: Vitest para regras academicas e componente; Playwright para BDD browser e screenshots.

**Target Platform**: Web responsiva desktop/mobile.

**Project Type**: Monorepo npm com app frontend.

**Constraints**: Sem backend; uma User Story; no maximo 5 tasks neste ciclo; nao usar `docs/` como fonte operacional.

## Stitch Preflight

O Stitch MCP era obrigatorio pela spec, mas nao esta exposto como ferramenta executavel nesta sessao. O executor registrou o bloqueio e aplicou o fallback operacional permitido na spec: usar `.stitch/DESIGN.md` e `.stitch/SITE.md` como fontes locais do design enquanto o MCP nao estiver disponivel.

Componentes confirmados pelas fontes operacionais locais e pela Issue #1:

- Marca Alexandria UFSC.
- Navegacao futura: Calculadora, Grade Curricular, Projetos, Configuracoes, Disciplinas, Historico, Simulador e Perfil.
- Cabecalho "Simulador de Notas".
- Card "Dados da Disciplina".
- Avaliacoes iniciais P1/P2, acao "Adicionar Avaliacao" e remocao.
- Secao "Simulacao de Recuperacao (REC)".
- CTA "Calcular Resultado".
- Cards "Media Parcial" e "Criterios UFSC".

## Project Structure

```text
Alexandria-UFSC/
├── package.json
├── apps/
│   └── web/
│       ├── app/
│       ├── e2e/
│       ├── src/
│       │   ├── components/
│       │   └── lib/
│       └── tests/
└── output/
    └── playwright/
```

**Structure Decision**: usar `apps/web` para manter o produto pronto para monorepo, mesmo sem pacotes compartilhados nesta v1.

## Implementation Notes

- Concentrar regras academicas puras em `src/lib/academic.ts` para teste unitario.
- Manter a tela como componente client-side controlado, sem API remota.
- Usar labels visiveis, foco perceptivel, mensagens junto aos campos e alvos de toque de pelo menos 44px.
- Usar Noto Serif, Inter e Public Sans via CSS font-family com fallback local; nao depender de carregamento remoto de fontes.
- Capturar screenshots desktop/mobile em `Alexandria-UFSC/output/playwright/`.
