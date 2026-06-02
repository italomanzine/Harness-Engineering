# Browser Validation

Use browser tools only for UI, UX, DOM, screenshot, accessibility, visual evidence, and debugging workflows.

## Primary Tool: Playwright

Use `.agents/skills/playwright/SKILL.md` and the `playwright` MCP server for:
- manual browser journeys;
- BDD flow verification;
- DOM/accessibility snapshots;
- screenshots for PR evidence;
- responsive checks;
- repeatable UI interactions.

Artifacts should go under `output/playwright/` unless a feature contract specifies another path.

## Diagnostic Tool: Chrome DevTools

Use `.agents/skills/chrome-devtools/SKILL.md` and the `chrome-devtools` MCP server only when Playwright evidence is not enough.

Use it for:
- console logs;
- network inspection;
- performance traces;
- live DOM debugging;
- Chrome-specific rendering problems.

Chrome DevTools is complementary. It is not the primary browser validation gate.

## Required UI Evidence

When `visualEvidenceRequired=true` in `evaluation-contract.json`, the contract must list screenshot or trace files under `visualEvidence`.

`scripts/evaluate.sh <feature-dir>` verifies that those evidence files exist before allowing PASS.
