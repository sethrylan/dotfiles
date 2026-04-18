---
description: Review a GitHub PR for tradeoffs, then optionally approve and mark the matching #copilot-api-reviewers Slack message with :approved-pr:
argument-hint: <pr-url>
allowed-tools: Bash, AskUserQuestion, TaskCreate, TaskUpdate, TaskList
---

Review the PR at: $ARGUMENTS

This command reviews a PR the way Seth would: focused on tradeoffs and design, not mechanical lint. On approval, it reacts to the matching Slack message in `#copilot-api-reviewers` with `:approved-pr:`.

## Phase tracking

This command runs as a fixed sequence of phases. Surface them as a todo list via `TaskCreate` **before doing anything else** so the user can see the full plan up front and watch progress as each phase moves to `in_progress` → `completed`. The task list IS the user-facing structure of this command — don't skip it, don't reorder it, don't batch updates.

Create these six tasks in order:

1. `Gather PR + Slack context` — activeForm `Gathering PR and Slack context`
2. `Cross-reference codebase` — activeForm `Cross-referencing codebase`
3. `Ask clarifying questions (if needed)` — activeForm `Asking clarifying questions`
4. `Render review` — activeForm `Rendering review`
5. `Approval prompt` — activeForm `Awaiting approval decision`
6. `Approve + Slack reaction` — activeForm `Approving PR and reacting in Slack`

Mark each `in_progress` when you start it and `completed` immediately when done. Don't batch. Tasks that are no-ops for this PR (e.g. no clarifying questions needed, user picks Skip on approval) should still be marked `completed` so the list closes cleanly.

## Step 1 — Gather PR context (and find the Slack message early)

Run these in parallel via Bash:

- `gh pr view <url> --json number,title,author,body,headRefName,baseRefName,url,isDraft,state,reviewDecision,labels,comments,reviews`
- `gh pr checks <url>`
- `gh pr diff <url>`
- `slack-reader message list "#copilot-api-reviewers" --workspace github --limit 500` — pipe through `jq` to find the matching message **now**, not after approval. Filter: messages from the last 7 days whose `text` contains the PR URL or the `<owner>/<repo>/pull/<num>` path fragment. Pick the most recent (largest `ts`). Save the `ts` for Step 5.

  Use this jq filter (handles null `text` safely — the bug from a prior run):
  ```
  jq -r --arg pr "<owner>/<repo>/pull/<num>" '
    .messages
    | map(select(.text != null and (.text | contains($pr))))
    | sort_by(.ts) | last | .ts // empty
  '
  ```

  **Channel ID is hardcoded**: `C08LLFPG83Y` (copilot-api-reviewers). Don't try to resolve it via `conversations.list` or `slack-reader channel list` — both omit private channels the bot isn't in. The PR template body also embeds this ID in the reviewer-channel link, which is a reliable secondary source if the hardcoded value ever drifts.

  If no matching message is found in the last 7 days, note it in the rendered review under a `## 📣 Slack` section so the user knows the Slack reaction step will be skipped — don't fail the whole review.

From `body` and `comments`, extract:
- **Linked issues**: parse `#NNN`, `owner/repo#NNN`, full `https://github.com/.../issues/NNN` URLs, and any "Closes/Fixes/Resolves" references.
- **Self-review**: comments and review comments authored by the PR author themselves.

For each linked issue, fetch in parallel:
- `gh issue view <ref> --json title,body,state,labels,url`

## Step 2 — Cross-reference the codebase

Treat the PR description as **guidance, not ground truth**. Trust, but verify. The author's framing of the change is a hypothesis — confirm it against the repo before repeating it back.

For every meaningful symbol the diff touches — env vars, config keys, function/method names, struct fields, types, exported constants, route paths, feature-flag names, CLI flags, schema fields, generated-code outputs — search the rest of the repo for consumers and references:

- `gh api -X GET search/code -f q="<symbol> repo:<owner>/<repo>" --jq '.items[].path'` for each symbol of interest.
- For files in the diff, check if related docs, READMEs, `.env.example`, comments, or tests reference the same symbol and need updating.
- Look for **directly connected changes**: stacked PRs, follow-up PRs the description names, or open PRs that touch the same files (`gh pr list --search "<file or symbol>"`).

You're hunting for two specific things:

1. **Unintended side-effects** — the change is read in a place the author may not have considered (active consumers, validators, tests that pin the old shape, generated code, deployment configs in another repo).
2. **Stale references** — comments, docs, examples, or tests that describe the old behavior and now lie.

**Description vs. reality.** If the PR description says or implies something that the code contradicts (e.g. "no Go reads this yet" but a grep finds an active consumer; "behind a feature flag" but the call site is unguarded; "internal only" but it's exported), call that out *explicitly* in the review under a **Description vs. reality** bullet. Don't soften it — it's the most useful thing you can surface.

Skip cross-referencing only when the diff is genuinely self-contained (a single test file, a one-off script, a doc fix). When in doubt, grep.

## Step 3 — Ask clarifying questions (only when human context is required)

After cross-referencing, decide if any question about this PR genuinely **cannot be answered** from the PR description, the diff, the linked issues, the Slack thread, or by grepping the repo. The bar is high — this phase exists for tradeoffs that hinge on human judgment or out-of-band context, not for things you could find with one more `gh` call.

**Ask only when**:

- The PR makes a tradeoff (architectural, scope, deprecation, perf-vs-clarity) where reasonable reviewers would disagree, and your read of the surrounding code doesn't reveal which side the team has already chosen.
- The PR touches a system whose operational context (incidents, deploys, ownership, downstream consumers in another repo) would change your assessment, and that context isn't in the diff or commit history.
- Two plausible interpretations of the change lead to materially different review verdicts (e.g. "is this a temporary hack to unblock a deploy, or the new pattern?").

**Don't ask when**:

- The answer is in the PR body, comments, linked issue, diff, or repo (`grep` first).
- It's a stylistic nit or curiosity — these belong in inline review comments, not blocking questions.
- You're just trying to look thorough. Asking pointless questions is worse than not asking.

If there are no genuine questions, **skip this phase entirely** — mark the task `completed` and move on. Don't fabricate a question to fill the slot.

If there are 1–4 real questions, call `AskUserQuestion` with them. After receiving answers, fold the user's responses into your Step 4 review (cite them where they shape a finding — `> 💬 Per Seth: <answer> — <how it changed the review>`).

## Step 4 — Render the review

Render with strong visual structure and a generous use of color. Use H2 (`##`) section headers with a leading emoji marker, blockquote callouts for high-signal findings, tables where they aid scanning, and **bold lead-in labels** at the start of bullets. Sprinkle inline emoji status markers (🟢🟡🔴⚠️✅❌🔍🧪📦🚧🛡️🐌⚡📈) to break up walls of text. Be terse inside each section — visual structure does the work, not filler words.

Output sections in this exact order. Omit a section entirely (don't print an empty header) when there's nothing to say.

### Required sections

```
---
## 🔖 PR
**#<num> — <title>**
👤 `<author>` · 🌿 `<base>` ← `<head>` · <state-badge> · 🔗 [open](<url>)
```
Where `<state-badge>` is one of: `🟢 OPEN`, `🟣 MERGED`, `🔴 CLOSED`, `📝 DRAFT`, plus `✅ APPROVED` / `🔄 CHANGES REQUESTED` if a review decision exists. Add a horizontal rule (`---`) above each H2 to give the sections breathing room and clearer visual separation.

```
---
## 🚦 CI
```
- All green → single line: `✅ **all green**`.
- Otherwise → table of failing/pending checks: `| Check | State | Link |` — prefix state cells with 🔴/🟡/⏳ to color the row at a glance.

```
---
## 📋 Summary
```
2–4 sentences of what the PR actually does. Strip PR-template boilerplate.

### Conditional sections

```
---
## 🔗 Linked issues
```
One line each — `**#NNN** <title> — <constraint or motivation>`. Skip if none.

```
---
## 🪞 Author self-review
```
Bullet the author's own comments on the diff. Skip if none.

```
---
## 📣 Slack
```
Include only when the Step 1 Slack lookup found *no* matching message in the last 7 days. One line: `⚠️ No matching message in #copilot-api-reviewers — Slack reaction will be skipped on approve.` Omit if a message was found.

```
---
## ⚠️ Description vs. reality
```
Include *only* when cross-reference found a contradiction. Format each finding as a blockquote pair so the contrast pops:
```
> 🗣️ **Claim:** <what the description says>
> 🔎 **Reality:** <what the code shows>
```
Omit the section if description matches reality.

```
---
## 🔍 Review — tradeoffs & design
```
The core section. Use **bold lead-in labels** at the start of each bullet so reviewers can scan, and prefix each lead-in with a topical emoji so the bullets read like a colored legend. Suggested mapping (use the closest fit; don't force):

- 🧭 **Choice vs. alternatives** — what was picked, what was plausible, how it constrains future work
- 💥 **Coupling / blast radius / reversibility** — informed by Step 2 consumers
- 🔌 **Contract changes** — interface/migration cost
- 🐌 **Failure modes** — performance, concurrency, error paths
- 🧪 **Tests** — do they exercise the *risk* in this change, or just the happy path?
- 📚 **Stale references** — docs, comments, examples the diff should have updated
- 🎯 **Intent drift** — anything contradicting the linked issue

Skip nits, style, naming, typos. Only mention if they signal a real misunderstanding.

For findings that should jump out, wrap them as a callout — these are the most important visual signal in the review, so reach for them when something matters:
```
> 🟢 <improvement worth highlighting>
> 🟡 <finding the author should weigh before merging>
> 🔴 <finding that should block merge>
```

```
---
## 💥 Worst-case scenario
```
Always include this section. 1–2 sentences max: the most damaging plausible outcome 1–6 months out, plus how it's detected. Be concrete about the failure chain — not generic. The user will ask for more if they want it. If the worst case is genuinely minor, say so in one line.

## Step 5 — Approval prompt

Call `AskUserQuestion` with one question:

- Question: "Approve this PR?"
- Header: "Decision"
- Options:
  - `✅ Approve` — "Approve via gh pr review and react to the matching Slack message with :approved-pr:"
  - `Skip` — "Don't approve, take no GitHub or Slack action"

## Step 6 — On Approve, approve the PR and react in Slack

If the user picked `✅ Approve`:

1. **Approve the PR via gh** (do this first, in parallel with the Slack reaction if a `ts` was found in Step 1):
   ```
   gh pr review <url> --approve
   ```
   If `gh pr review` fails (e.g. PR author can't self-approve, no permission, already approved by you), surface the exact error to the user but still attempt the Slack reaction — those are independent.

2. **React in Slack** using the `ts` and channel ID `C08LLFPG83Y` already resolved in Step 1:
   ```
   gh slack api post reactions.add -t github \
     -b '{"channel":"C08LLFPG83Y","timestamp":"<ts>","name":"approved-pr"}'
   ```
   If Step 1 found no matching message, skip this and report it explicitly.

3. Report both outcomes:
   - `✅ Approved PR via gh pr review` (or the error)
   - `✅ Reacted to message <ts> in #copilot-api-reviewers with :approved-pr:` (or `⚠️ skipped — no matching Slack message`)

If the user picked `Skip`: end the turn. No GitHub or Slack action.
