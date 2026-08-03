---
name: local-to-issues
description: Break a plan, spec, or PRD into independently-grabbable issue files saved to docs/issues/ in the current project. Local file-based alternative to `to-issues` — no issue tracker required. Use when user wants to convert a plan into local issue files, create implementation tickets as markdown, or break down work into issues without publishing to GitHub.
---

# local-to-issues

Local variant of `to-issues`. Breaks a plan into vertical-slice issue files written to `docs/issues/<NNN>-<slug>.md`. No external system required.

## Process

### 1. Gather context

Work from whatever is already in the conversation. If the user passes a path to a local PRD or issue file as an argument, read it.

### 2. Explore the codebase (if not already done)

Issue titles and descriptions should use the project's domain glossary vocabulary and respect ADRs in the area being touched.

### 3. Draft vertical slices

Break the plan into **tracer bullet** issues — thin vertical slices that cut through ALL layers end-to-end, not horizontal layer slices.

Each slice is either **HITL** (requires human interaction) or **AFK** (can be implemented and merged without human input). Prefer AFK.

<vertical-slice-rules>
- Each slice delivers a narrow but COMPLETE path through every layer (schema, API, UI, tests)
- A completed slice is demoable or verifiable on its own
- Prefer many thin slices over few thick ones
</vertical-slice-rules>

### 4. Quiz the user

Present the proposed breakdown as a numbered list. For each slice show:

- **Title**: short descriptive name
- **Type**: HITL / AFK
- **Blocked by**: which other slices must complete first
- **User stories covered**: if source material has them

Ask: Does the granularity feel right? Are dependencies correct? Any slices to merge or split?

Iterate until the user approves.

### 5. Write the issue files

Determine the next available issue number by counting files already in `docs/issues/` (pad to 3 digits: `001`, `002`, …). Create `docs/issues/` if it does not exist.

Write issues in dependency order (blockers first). Use the template below for each file.

Report all created file paths at the end.

## Issue file template

```markdown
# <NNN> — <Title>

**Type:** HITL | AFK
**Status:** open
**Blocked by:** <NNN> — <Title> | None

## What to build

A concise description of this vertical slice. Describe end-to-end behavior, not layer-by-layer implementation.

Avoid specific file paths or code snippets (they go stale). Exception: prototype snippets encoding a decision precisely — inline and note they came from a prototype.

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2

## Parent

Path to the source PRD or issue file (if applicable), otherwise omit.
```
