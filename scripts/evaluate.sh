#!/bin/bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <feature-dir>" >&2
  exit 1
fi

SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(CDPATH="" cd "$SCRIPT_DIR/.." && pwd)"

python3 - "$REPO_ROOT" "$1" <<'PY'
import datetime
import json
import pathlib
import subprocess
import sys

root = pathlib.Path(sys.argv[1]).resolve()
feature_arg = pathlib.Path(sys.argv[2])
feature_dir = (root / feature_arg).resolve() if not feature_arg.is_absolute() else feature_arg.resolve()

contract_path = feature_dir / "evaluation-contract.json"
sensors_path = root / ".harness" / "sensors.json"
memory_dir = root / ".memory"
last_eval_path = memory_dir / "last-evaluation.json"

mandatory = [
    "featureDir",
    "branch",
    "scope",
    "requirements",
    "bddScenarios",
    "checks",
    "visualEvidenceRequired",
    "maxCycles",
]

errors = []
results = []

def display_path(path):
    try:
        return str(path.relative_to(root))
    except ValueError:
        return str(path)

def load_json(path, label):
    try:
        with path.open("r", encoding="utf-8") as fh:
            return json.load(fh)
    except FileNotFoundError:
        errors.append(f"{label} ausente: {path}")
    except json.JSONDecodeError as exc:
        errors.append(f"{label} inválido: {path} ({exc})")
    return {}

contract = load_json(contract_path, "Contrato de avaliação")
sensors_config = load_json(sensors_path, "Configuração de sensores")

for field in mandatory:
    if field not in contract:
        errors.append(f"Campo obrigatório ausente no contrato: {field}")

contract_feature = contract.get("featureDir")
if contract_feature:
    expected = (root / contract_feature).resolve()
    if expected != feature_dir:
        errors.append(f"featureDir do contrato ({contract_feature}) não corresponde ao argumento ({feature_arg})")

checks = contract.get("checks")
if not isinstance(checks, list) or not checks or not all(isinstance(item, str) and item.strip() for item in checks):
    errors.append("checks deve ser uma lista não vazia de sensores")
    checks = []

for array_field in ("scope", "requirements", "bddScenarios"):
    value = contract.get(array_field)
    if not isinstance(value, list) or not value:
        errors.append(f"{array_field} deve ser uma lista não vazia")

max_cycles = contract.get("maxCycles")
if not isinstance(max_cycles, int) or max_cycles < 1:
    errors.append("maxCycles deve ser um inteiro maior que zero")

if contract.get("visualEvidenceRequired") is True:
    evidence = contract.get("visualEvidence")
    if not isinstance(evidence, list) or not evidence:
        errors.append("visualEvidenceRequired=true exige visualEvidence com pelo menos um arquivo")
    else:
        for item in evidence:
            evidence_path = (root / item).resolve()
            if not evidence_path.exists():
                errors.append(f"Evidência visual ausente: {item}")

sensors = sensors_config.get("sensors", {})
if not isinstance(sensors, dict):
    errors.append(".harness/sensors.json deve conter objeto sensors")
    sensors = {}

for check in checks:
    sensor = sensors.get(check)
    if not isinstance(sensor, dict):
        errors.append(f"Sensor não configurado: {check}")
        continue

    command = str(sensor.get("command", "")).strip()
    if not command:
        errors.append(f"Sensor sem comando configurado: {check}")
        results.append({
            "name": check,
            "status": "FAIL",
            "exitCode": None,
            "command": command,
            "reason": "empty command"
        })
        continue

    proc = subprocess.run(
        command,
        cwd=root,
        shell=True,
        executable="/bin/bash",
        text=True,
        capture_output=True,
    )
    results.append({
        "name": check,
        "status": "PASS" if proc.returncode == 0 else "FAIL",
        "exitCode": proc.returncode,
        "command": command,
        "stdout": proc.stdout[-4000:],
        "stderr": proc.stderr[-4000:],
    })
    if proc.returncode != 0:
        errors.append(f"Sensor falhou: {check} (exit {proc.returncode})")

status = "PASS" if not errors else "FAIL"
payload = {
    "status": status,
    "featureDir": str(feature_arg),
    "contract": display_path(contract_path),
    "evaluatedAt": datetime.datetime.now(datetime.timezone.utc).isoformat(),
    "checks": results,
    "errors": errors,
}

memory_dir.mkdir(parents=True, exist_ok=True)
with last_eval_path.open("w", encoding="utf-8") as fh:
    json.dump(payload, fh, indent=2, ensure_ascii=False)
    fh.write("\n")

print(f"Evaluation: {status}")
print(f"Feature: {feature_arg}")
print(f"Result: {last_eval_path.relative_to(root)}")
if errors:
    print("Failures:")
    for error in errors:
        print(f"- {error}")

sys.exit(0 if status == "PASS" else 1)
PY
