---
name: pr
description: Review branch diff, then create a GitHub PR with description filled from the repo's PR template or mirrored from recent merged PRs, attaching UI screenshots when the change is visual, then autonomously monitor the PR thread and resolve review nits/advisories until the review is clean. Use when the user says /pr, "create a PR", "open a pull request", or finishes a branch and wants it published.
---

# PR

Review-first PR creation. Never skip the review gate.

## Steps

1. **Preflight** — verify: not on main/master, working tree committed (prompt to commit leftovers first), `gh auth status` ok. Determine base branch.

2. **Review gate** — show `git diff <base>...HEAD --stat`, then summarize the full diff change-by-change (file:line for anything notable). Per-task commits stay intact — never rebase/squash/unstage for review; use `git log -p <base>..` if per-commit view helps. **Wait for user ok before pushing anything.**

3. **Description source**, in priority order:
   - `.github/PULL_REQUEST_TEMPLATE.md` or `docs/pull_request_template.md` in the repo → fill every section; check the correct checkboxes honestly (testing actually done, dashboards actually affected).
   - Otherwise: `gh pr list --state merged --limit 5` + `gh pr view` on 2-3 → mirror their title convention and body structure.
   - Title: match the repo's merged-PR/commit convention (e.g. `feat(scope): summary`).

4. **Screenshots (UI changes only)** — if the diff touches UI and the template demands screenshots:
   - App running? (check dev-server pane via `/opt/homebrew/bin/tmux capture-pane`, or ask). Use Playwright MCP: navigate to affected pages, capture before/after where possible (`git stash` for "before" only if working tree is clean and user agrees).
   - Save to `/tmp/pr-screenshots/<branch>/`.
   - `gh` cannot upload images to PR bodies. Default: leave a `<!-- screenshot: name.png -->` placeholder per image in the body and send the files to the user via SendUserMessage attachments to drag-drop into GitHub. Alternative (only if the repo already has a committed-assets precedent): commit images to the branch and embed raw URLs.

5. **Create** — push branch (`-u origin`), `gh pr create` with title + body. Body via heredoc/file to preserve formatting.

6. **Report** — PR URL, anything left manual (screenshot drag-drop, reviewer assignment).

7. **Autonomous review loop** — after reporting, monitor the PR thread and resolve review feedback until it's clean, without waiting for the user to relay comments. This is a self-paced dynamic loop (same machinery as the `loop` skill — Monitor + ScheduleWakeup):
   - **Baseline** — record the newest comment id on the thread now (`gh api repos/<owner>/<repo>/issues/<pr>/comments --jq '[.[].id]|max'`), so you only react to *new* activity.
   - **Arm a persistent Monitor** on the thread that emits one line per comment newer than the baseline, advancing the baseline as it goes (poll ≥60s; `|| true` on the `gh` call so a transient failure doesn't kill it). Also fetch `gh pr checks <pr>` and the review verdict body when a new comment lands — the automated reviewer (e.g. `claude-review`) posts its findings as an issue comment after each push.
   - **Schedule a long fallback heartbeat** (1200–1800s) as a safety net; the Monitor is the primary wake signal. Pass the `/loop`-style prompt verbatim so a wake re-enters this step.
   - **On each new comment** — parse it. If it raises an *issue, nit, or advisory*: fix it (commit + push, which re-triggers review), then reply on the thread explaining what you changed or — for points you deliberately decline — why (cite precedent/config, as you would in `receiving-code-review`). If it's approval/chatter, note it and keep watching.
   - **Exit condition** — stop the loop (omit the next ScheduleWakeup, `TaskStop` the Monitor) once the latest review verdict has **zero issues, zero nits, zero advisory** (e.g. an explicit LGTM) *and* CI is green. Report the clean state. Never let "advisory only / safe to merge" end the loop while any nit text remains unaddressed — address or explicitly decline each one first.
   - This loop **never merges** (see Rules). Getting to a clean review ≠ merging.

## Rules

- **Never merge a PR yourself.** Even when CI is green, there is a human approval, and the latest review has zero issues and zero nits, do NOT run `gh pr merge` (or any equivalent) and do NOT enable auto-merge. A human must click "Merge" on GitHub. Your job is to get the PR fully ready — green CI, branch current with base, all review issues *and* nits resolved — and then leave the final merge click to a human.
- Review gate is blocking — no push before user ok.
- Fill templates truthfully; never check "Unit Tests" boxes for tests that don't exist.
- Don't invent ClickUp/Figma links — leave the template line with a `TODO` for the user.
