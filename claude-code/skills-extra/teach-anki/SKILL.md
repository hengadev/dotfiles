---
name: teach-anki
description: Extends the teach skill with Anki flashcard integration for spaced repetition. Proposes candidate cards after lessons, lets the user review/approve/edit/reject each one individually, then creates approved cards via the homelab Anki API. Use when teaching a topic and the user wants Anki cards, mentions "add a card", "create a deck", "add this to Anki", or asks for spaced repetition alongside their lessons.
---

# teach-anki

Companion to the [teach skill](../teach/SKILL.md). All workspace conventions (MISSION.md, lessons/, learning-records/, etc.) apply unchanged. This skill adds an Anki review-and-create loop on top of any teaching session.

## Deck name

Infer the deck name from MISSION.md or the current topic. Always confirm with the user before creating:

  Deck: "Go Concurrency" — OK, or rename it?

## When to propose cards

- After completing a lesson: offer to propose cards for what was just taught
- On explicit request: "add a card about X", "create a deck for this", "add this to Anki"

Never create cards silently. Always go through the review step first.

## Card type selection

Choose the card type based on what the user needs to retrieve — not by habit or subject alone. A single lesson may warrant several types. See REFERENCE.md for the full type guide and subject recommendations.

Core types:

- **Basic** — isolated fact, definition, formula; plain Q/A
- **Cloze** — fill-in-the-blank; embed answer as `{{c1::answer}}`; good for syntax, vocabulary, formulas
- **Process** — ordered steps; front states the goal, back lists the numbered steps
- **Comparison** — A vs B; front names both things, back contrasts them on key dimensions
- **Why** — causal reasoning; front asks why/how, back gives the mechanism or consequence
- **Error** — debugging intuition; front shows broken code or logic, back explains the fix and why

## Review step

Show proposed cards numbered with type labelled. Wait for a response before calling the API:

  Proposed cards → deck: "Go Concurrency"

  1. [Cloze] The {{c1::sync.Mutex}} type is used to protect shared state in Go.
  2. [Why] Why does a goroutine leak occur?
     A: When a goroutine blocks forever waiting on a channel nobody writes to.
  3. [Process] How do you profile a Go binary?
     A: 1. Import net/http/pprof  2. Expose /debug/pprof  3. Run go tool pprof

  Reply: "approve all" · "1 3" (specific numbers) · "edit 2" · "reject all"

Apply any edits inline before sending. Do not call the API until the user has confirmed.

## After approval

Call the API for each approved card. See REFERENCE.md for endpoints and curl examples.

Read `ANKI_API_KEY` from env — never hardcode it. If the env var is unset or the API is unreachable: warn the user, mark cards as pending in `anki-cards.md`, and continue the session without interruption.

## Tracking (./anki-cards.md)

Check this file before proposing cards — skip anything already logged to avoid duplicates. Append after successful creation:

  ## [Deck Name] — YYYY-MM-DD
  - [Cloze] The {{c1::sync.Mutex}} type is used to protect shared state in Go.
  - [Why] Q: Why does a goroutine leak occur? | A: Blocked forever on a channel nobody writes to.

Mark failed/unreachable cards as `[pending]` — retry them at the start of the next session.

## Workspace additions (on top of teach skill)

- `./anki-cards.md` — log of all cards sent to Anki, plus any pending retries
