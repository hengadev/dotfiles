# Anki API Reference

Base URL: `https://anki-api.henga.dev`
Auth: `X-API-Key: $ANKI_API_KEY`

## Endpoints

| Method | Path | Body |
|--------|------|------|
| GET | /decks | — |
| POST | /decks | `{"name": "Deck Name"}` |
| POST | /cards | see below |

### POST /cards body

```json
{
  "deck": "Deck Name",
  "type": "basic",
  "front": "Question text",
  "back": "Answer text"
}
```

For **cloze** cards: `type` is `"cloze"`, `front` holds the full cloze text with `{{c1::...}}` markers, `back` is omitted.

## Curl examples

```bash
# List decks
curl -s -H "X-API-Key: $ANKI_API_KEY" https://anki-api.henga.dev/decks

# Create deck
curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $ANKI_API_KEY" \
  -d '{"name":"Go Concurrency"}' \
  https://anki-api.henga.dev/decks

# Add basic card
curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $ANKI_API_KEY" \
  -d '{"deck":"Go Concurrency","type":"basic","front":"What does sync.Mutex protect?","back":"Shared state — prevents data races under concurrent reads/writes."}' \
  https://anki-api.henga.dev/cards

# Add cloze card
curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $ANKI_API_KEY" \
  -d '{"deck":"Go Concurrency","type":"cloze","front":"Use {{c1::sync.WaitGroup}} to wait for a collection of goroutines to finish."}' \
  https://anki-api.henga.dev/cards
```

## Error handling

| Code / condition | Cause | Action |
|------------------|-------|--------|
| 401 | Wrong or missing API key | Warn user; check `ANKI_API_KEY` env var |
| 404 on POST /cards | Deck does not exist | POST /decks first, then retry |
| 5xx / timeout / refused | API unreachable | Mark cards as `[pending]` in anki-cards.md; retry next session |

## Card type guide

Choose by what the user needs to retrieve, not by subject alone. Multiple types in one lesson is normal.

| Type | Front | Back | Best for |
|------|-------|------|----------|
| Basic | Question / prompt | Answer | Facts, definitions, formulas |
| Cloze | Sentence with `{{c1::gap}}` | *(auto-generated)* | Syntax, vocabulary, fill-in |
| Process | "How do you do X?" | Numbered steps | Procedures, workflows, setup |
| Comparison | "A vs B — key differences?" | Table or bullet contrasts | Sibling concepts, trade-offs |
| Why | "Why does X happen?" | Mechanism / consequence | Causality, design decisions |
| Error | Broken code or faulty logic | Fix + explanation | Debugging instincts |

### Subject heuristics (starting point, not a rule)

| Subject | Often useful |
|---------|-------------|
| Mathematics | Basic (recognition→action), Why, Process |
| Algorithms | Comparison, Why, Error |
| Programming languages | Error, Cloze, Process |
| Systems / OS | Process, Why |
| Natural languages | Cloze, Basic (sentence) |
| Networking | Process, Comparison |
| Databases | Process, Comparison |
| Machine Learning | Why, Process |
