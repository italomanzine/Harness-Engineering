# Docs

Esta pasta contém exemplos, referências visuais e material de apoio para a palestra.

## Regra

Os arquivos em `docs/` não são fonte operacional do harness.

Agentes e fluxos não devem depender diretamente de arquivos desta pasta para executar `/refine`, `/intent`, validação, revisão ou abertura de PR.

## Fontes operacionais

Use estes arquivos e diretórios para operar o harness:

- `AGENTS.md`
- `.github/copilot-instructions.md`
- `GEMINI.md`
- `.harness/workflow.md`
- `.agents/roles/`
- `.agents/skills/`
- `.specify/`
- `.stitch/`
- `specs/`
- `scripts/validate.sh`

## Uso permitido

- Exemplos em aula.
- Inspiração para criar agentes ou skills.
- Material conceitual para explicar Harness Engineering.
- Referência histórica durante manutenção manual do projeto.

Se algum exemplo de `docs/` virar parte do harness, mova ou copie o conteúdo necessário para uma fonte operacional antes de usá-lo.
