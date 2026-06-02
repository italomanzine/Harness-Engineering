# Harness Engineering Constitution

## Core Principles

### I. Spec Before Code
Every feature starts with a Spec Kit specification in `specs/<slug>/spec.md`.
The spec describes observable behavior, user value, scope boundaries, and BDD
acceptance scenarios before implementation begins.

### II. BDD For Behavior
Acceptance criteria must be written as Given/When/Then scenarios. In Portuguese
teaching material, use the equivalent `Dado / Quando / Então`. Every scenario
must map to an automated test, E2E test, or explicitly justified visual/manual
evidence.

### III. TDD Is Non-Negotiable
Implementation follows Red -> Green -> Refactor. Production code for a feature
must be preceded or accompanied by a failing test that proves the expected
behavior. The Reviewer blocks PRs that add behavior without verification.

### IV. Traceable Plan And Tasks
Every `/intent` flow must produce or validate `specs/<slug>/plan.md` and
`specs/<slug>/tasks.md`. It must also produce
`specs/<slug>/evaluation-contract.json`. Tasks must reference requirements,
user stories, BDD scenarios, dependencies, and verification criteria.

### V. Branch Discipline
Never work directly on `main` or `master`. Feature work must happen on
`feature/<slug>` created from `main`, and the final delivery must be a PR to
`main` through GitHub MCP.

### VI. Visual Fidelity For Frontend
Frontend work must use Stitch MCP when a prototype exists. PRs must include
visual evidence, and the target is at least 98% similarity with the approved
Stitch design.
UI/UX work must also use `ui-ux-pro-max` for accessibility, interaction,
responsive behavior, typography, color, spacing, and hierarchy checks.
Browser validation must use Playwright as the primary tool for journeys,
snapshots, and screenshots. Chrome DevTools is complementary for console,
network, performance traces, and live DOM diagnostics.

## Harness Standards

- GitHub Spec Kit is the SDD backbone: Spec -> Plan -> Tasks -> Implement.
- `tlc-spec-driven` is a helper skill for auto-sizing, memory, brownfield
  mapping, and resumable work.
- `scripts/validate.sh` is the minimum validation gate before review.
- `scripts/evaluate.sh <feature-dir>` is the binary gate before PR review.
- `.harness/sensors.json` defines deterministic external sensors by name.
- `.memory/progress.md` and `.memory/last-evaluation.json` prevent session
  amnesia and premature victory.
- GitHub MCP is used for Issues, Projects, PRs, discussion comments, and visual
  evidence.
- Stitch MCP is used for design context, screenshots, and visual validation.
- `ui-ux-pro-max` is used as the UI/UX quality layer for frontend work.
- Playwright is the primary browser validation layer.
- Chrome DevTools is the complementary debugging layer.

## Development Workflow

1. `/refine`: Product Manager creates `specs/<slug>/spec.md` and GitHub Project
   cards with BDD scenarios.
2. `/intent`: Orchestrator reads the card/spec, creates `feature/<slug>`,
   ensures `plan.md`, `tasks.md`, and `evaluation-contract.json`.
3. Evaluator validates the contract before implementation.
4. Coder implements with TDD and keeps the diff inside the spec scope.
5. Evaluator runs `scripts/evaluate.sh <feature-dir>` and emits PASS or FAIL.
6. Reviewer checks SDD/TDD/BDD traceability, security, tests, drift, and Stitch
   visual evidence.
7. GitHub MCP opens the PR to `main` only after PASS.

## Governance

This constitution overrides ad hoc prompts and local agent preferences. Changes
to the harness flow must update `AGENTS.md`, `.harness/workflow.md`,
`.github/copilot-instructions.md`, `GEMINI.md`, and the relevant operational
agent or Spec Kit files when relevant.

The `docs/` directory is non-operational. It contains lecture examples and
inspiration only. Do not depend on files in `docs/` for `/refine`, `/intent`,
validation, review, or PR creation.

**Version**: 1.0.0 | **Ratified**: 2026-06-02 | **Last Amended**: 2026-06-02
