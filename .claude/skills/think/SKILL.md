---
name: think
description: Pure thinking mode — investigate read-only and report findings plus open questions, with zero file edits, no commands that change state, and no implementation. Use when the user says /think, "let's just think", "think first", "no changes, just look", or wants analysis before deciding anything.
---

# Think

Joint thinking session. The deliverable is understanding, not change.

## Hard rules

- **No mutations.** No Edit/Write/NotebookEdit, no state-changing Bash (no install, restart, delete, config write, git commit). Read, grep, list, fetch, capture — fine.
- **No plans.** Do not produce an implementation plan, step list, or "here's what I'll do next". That's a different mode.
- **No premature fixes.** Even if the fix looks obvious, name it as a finding, don't apply it.

## Output shape

End every /think response with exactly two sections:

1. **Findings** — what is true, with evidence (file:line, command output, doc link). Distinguish verified facts from inference. Say "unverified" when you didn't check.
2. **Open questions** — what's still unknown, what only the user can decide, what would change the conclusion. If a question is checkable read-only, offer to check it rather than ask the user.

Keep options analysis honest: trade-offs, not a sales pitch. A recommendation is allowed but mark it as opinion.

## Exiting the mode

Mode persists for the conversation until the user asks for a change ("apply", "fix it", "do it", or a concrete edit request). At that point normal rules resume — confirm scope if the change is bigger than what was discussed.
