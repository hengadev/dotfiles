---
target: waybar vertical layout (style-vertical.css)
total_score: 25
max_score: 40
na_heuristics: 
p0_count: 2
p1_count: 1
timestamp: 2026-07-31T19-54-08Z
slug: waybar-style-vertical-css
---
Method: dual-agent (A: general-purpose design review · B: general-purpose evidence audit)

## Design Health Score

| # | Heuristic | Score | Key Issue |
|---|-----------|-------|-----------|
| 1 | Visibility of System Status | 3 | Warning/critical states work, but sit across a large dead-space gap from the eye's natural scan path |
| 2 | Match System / Real World | 3 | Standard glyphs, legible conventions, no text labels needed |
| 3 | User Control and Freedom | 3 | All click-throughs (pavucontrol/nmtui/power-menu) reversible |
| 4 | Consistency and Standards | 2 | The margin-axis-swap *reasoning* is consistent with the horizontal bar's, but GTK's cross-axis stretch behaves so differently between the two orientations that the same code produces an incompatible result (see dot sizing below) |
| 5 | Error Prevention | 2 | Dot-workspace click targets (workspaces 6-10) are ~8px with tight margins — easy to miss |
| 6 | Recognition Rather Than Recall | 2 | CPU and memory glyphs are near-identical chip icons; only the number tells them apart |
| 7 | Flexibility and Efficiency | 3 | Scroll/click on workspaces, `format-alt` on clock — all preserved from the horizontal bar |
| 8 | Aesthetic and Minimalist Design | 1 | The core failure of this pass — see Priority Issues |
| 9 | Error Recovery | 3 | Color-coded thresholds are clear when they fire |
| 10 | Help and Documentation | 3 | Tooltips exist (memory, network, clock) — genuinely useful, not decorative |
| **Total** | | **25/40** | **Acceptable — solid bones, but the width problem you flagged is real and measurable** |

## Design Specificity Verdict

**Mechanically rotated, with one piece of real engineering that doesn't actually pay off.**

The margins were deliberately swapped axis-for-axis when the bar went from horizontal to vertical — `#workspaces button:nth-child(n+6)`'s dot-shrink trick flips from `margin: 14px 5px` to `5px 14px`, and the CSS comments show real reasoning about *why* (GTK stretches box children across the bar's cross-axis, which flips from height to width). That's not a lazy port.

But the two decisions that actually define whether a vertical bar earns its shape were never revisited:
- **Content still dictates rail width.** Every pill stretches to fill the column's width, and the column's width is set by whichever module's content is widest (`61°C`, `76%`). Nothing pins the rail to a fixed, narrow width — which is the entire premise of moving to vertical in the first place.
- **Modules-left/center/right still maps to thirds of the *screen*, not to a sensible vertical grouping.** On a 1080px-tall screen this produces two large empty gaps (visible in both screenshots) that read as "did something fail to load," not "intentional whitespace."

Assessment B's measurements confirm this isn't a matter of taste: the clock pill uses ~53% of its width for actual content, the battery pill only ~34% — a jagged, content-driven column that never stabilizes into a fixed narrow rail.

**Deterministic scan**: the bundled detector was run against `config-vertical` and `style-vertical.css` and returned `[]` (exit 0) on both. This is **not a clean bill of health** — the detector is built for browser-rendered markup and has no model for GTK box layout or a waybar JSON config, so an empty result here means "inapplicable," not "no issues." No false positives to report from it, because it produced no findings at all.

**One important correction between the two assessments**: Assessment A initially listed the dot-shrink axis-swap as a *strength* (evidence of careful, non-lazy porting). Assessment B then measured the actual rendered output and found the trick doesn't work in practice: the "dots" for workspaces 6-10 render as ~7:1 elongated horizontal bars, not circles, because `margin: 5px 14px` only had to shrink a narrow shared-row allocation in the horizontal bar, but in the vertical bar each button now owns the *entire* column width alone (no siblings to share it with) — the same margin value is nowhere near enough to shrink that down to a dot. So: correct instinct, wrong constant. The fix needs an explicit max-width/width on the dot, not a bigger margin guess.

## Overall Impression

The bones are fine — same palette, same threshold logic, same click-throughs — but this reads exactly like your instinct said: a horizontal bar that got rotated, not a vertical bar that got designed. The biggest opportunity is the one your reference image already nails: strip inline numeric text down to icon-only (with values in tooltips, which several modules already have), and pin the rail to a genuinely narrow fixed width instead of letting content dictate it.

## What's Working

- **Shared palette discipline.** Both variants pull from the same `palette-dark.css` tokens, and the "only real alerts get color" rule (a comment already present in the horizontal `style.css`) is honored here too — nothing looks like a different app.
- **Threshold-driven color stays intact.** CPU/memory/battery warning and critical states carry over correctly and are legible at rest.
- **Genuine (if incomplete) reasoning about orientation.** The margin-axis swap shows the author understood the GTK cross-axis-stretch mechanic, even though the specific values chosen don't achieve the intended silhouette (see above).

## Priority Issues

**[P0] Rail width is set by content, not by design.** GTK stretches every pill to the column's width, and that width is whatever the widest module (`61°C`, `76%`) demands — this is precisely the "too wide" complaint. *Why it matters*: it defeats the actual reason to have a vertical mode (reclaiming screen width on a wide monitor); a bar that grows to fit "76%" text is barely narrower than a normal sidebar. *Fix*: drop inline value text for cpu/memory/temperature/pulseaudio/network/battery in the vertical variant specifically — icon only, move the number into `tooltip-format` (already wired for memory/network/clock, just extend it to the rest) — and set an explicit fixed width on `window#waybar` (something in the 40-56px range) so content can never win that fight again.
**Suggested command**: `/impeccable layout`

**[P0] Two large dead-space gaps break the "am I looking at a working bar" feeling.** `modules-left/center/right` pins to top/middle/bottom thirds of the *screen height*, which made sense when it mapped to thirds of screen *width* horizontally but has no equivalent logic vertically. *Why it matters*: on first glance it reads as broken, not spacious — Assessment A's persona note on this is sharp: for a bar you glance at 50x/day, an empty void erodes trust. *Fix*: cluster everything at the top (mirroring the reference sidebar you linked), pin only the power button to the bottom, let the middle stay empty only if that empty space is deliberately minimal rather than screen-height/3.
**Suggested command**: `/impeccable layout`

**[P1] The "dot" workspace indicators don't look like dots.** Measured in the screenshot: they render as ~7:1 aspect-ratio horizontal bars, not circles, and at ~8px tall they're also a marginal click/scroll target. *Fix*: give them an explicit small fixed `width` (not just `min-width`) so the margin trick isn't fighting cross-axis stretch, and consider growing the effective hit target slightly beyond the visual dot (a transparent padding halo) rather than shrinking both together.
**Suggested command**: `/impeccable layout`

**[P2] CPU and memory icons are too similar to tell apart at rest.** Both are same-family "chip" glyphs, differing only in the number next to them — on a bar you're meant to scan quickly, that forces reading over recognizing.
**Suggested command**: `/impeccable clarify`

**[P3] Temperature has no warning stage.** CPU and memory both escalate warning→critical; temperature only has a critical threshold, breaking the otherwise-parallel escalation model across the three system stats.
**Suggested command**: `/impeccable harden`

## Persona Red Flags

**Alex (power user, checks this bar dozens of times a day)**: The dead-space gaps slow down his actual use case — a fast glance for status — and the "did something break" read undermines trust in exactly the surface that's supposed to be quietly reliable in the background.

**Sam (accessibility-dependent)**: The ~8px dot workspace targets fall well under typical minimum touch/click-target guidance. Separately — not confirmed either way, worth an explicit check rather than assuming — the muted `wb-fg-dim` icon color against the pill background is close enough to a contrast floor that it deserves an actual measurement, since that combination governs the "at rest" 90% of the time (unfocused workspace icons, muted network/audio states).

## Minor Observations

- Tooltip coverage is uneven — memory/clock/network get detailed tooltips, cpu/battery/pulseaudio don't. Low cost to make uniform once you're extending tooltips anyway for the icon-only fix above.
- The distro-accent color on the OS icon is a nice single touch of personality and carries over correctly — keep it.
- One open question flagged by Assessment B, not yet resolved: is the anki icon ("open book") too similar to a plain notebook glyph at this size? Worth a look once real content replaces this preview.

## Questions to Consider

1. If the whole point of vertical mode is reclaiming width, why does it keep every value as inline text instead of following the reference image's icon-only-plus-tooltip pattern?
2. Does "top/middle/bottom of the screen" need to exist as a layout metaphor at all here, or was left/center/right only ever meaningful because it mapped to thirds of screen *width* — a property vertical mode doesn't share?
3. Is a forced preview on a 1920px laptop screen actually representative, or does testing vertical mode on a screen that isn't wide make every width problem look worse than it will on the real 2560px+ target monitor?
