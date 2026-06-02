# Spec: Demo Feature

## User Story 1 - Harness demo validation

Como estudante, quero ver um contrato de avaliação mínimo, para entender que o harness só libera trabalho após sensores externos.

## Requirements

- **REQ-001:** O harness deve validar um contrato mínimo usando sensor determinístico.

## BDD Scenarios

### SCN-001: Contrato mínimo aprovado

```gherkin
Dado um contrato de avaliação com o sensor harness
Quando o Evaluator executa scripts/evaluate.sh
Então o resultado deve ser PASS
```
