---
name: local-to-prd
description: Turn the current conversation context into a PRD and write it to docs/prd/<slug>.md in the current project. Local file-based alternative to `to-prd` — no issue tracker required. Use when user wants to create a PRD from the current context and save it locally, mentions "local-to-prd", or wants a file-based PRD instead of publishing to GitHub.
---

# local-to-prd

Local variant of `to-prd`. Synthesises the current conversation into a structured PRD and writes it to `docs/prd/<slug>.md`. No external system required.

## Process

1. Explore the repo to understand the current state of the codebase, if you haven't already. Use the project's domain glossary vocabulary throughout the PRD, and respect any ADRs in the area you're touching.

2. Sketch out the major modules you will need to build or modify. Actively look for opportunities to extract deep modules — ones with a lot of functionality behind a simple, testable interface.

3. Check with the user that the modules match their expectations and which ones they want tests written for.

4. Derive a kebab-case slug from the feature name (e.g. `user-invite-flow`).

5. Create `docs/prd/` if it does not exist, then write the PRD using the template below.

6. Report the final file path to the user.

## PRD template

```markdown
# <Title>

**Status:** Draft
**Date:** YYYY-MM-DD

## Problem Statement

The problem the user is facing, from the user's perspective.

## Solution

The solution, from the user's perspective.

## User Stories

A long, numbered list of user stories:

1. As a <actor>, I want <feature>, so that <benefit>

## Implementation Decisions

- Modules to build/modify and their interfaces
- Architectural decisions
- Schema changes, API contracts, specific interactions

Do NOT include specific file paths or code snippets (they go stale).
Exception: prototype snippets encoding a decision (state machine, schema, type shape) — inline and note they came from a prototype.

## Testing Decisions

- What makes a good test for this feature
- Which modules will be tested
- Prior art in the codebase

## Out of Scope

What is explicitly excluded from this PRD.

## Further Notes

Any additional context.
```

## Notes

- Pair with `local-to-issues` to break the PRD into trackable local issue files.
- If the conversation is early-stage, leave open questions rather than inventing answers.
