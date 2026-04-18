---
description: Generate a self-contained HTML explainer page for a topic, system, or concept in the current repo — researched from code, git history, and linked PRs/issues.
argument-hint: <topic or area to explain>
allowed-tools: Agent, Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, TaskCreate, TaskUpdate, TaskList, WebFetch
---

Build a single self-contained HTML explainer for: **$ARGUMENTS**

This command produces an internal engineering doc page — light-mode, editorial, code-backed — that a teammate could open and understand the topic from cold. The output is a single `.html` file with inline CSS and vanilla JS (no build step, no external deps), saved into the current repo.

## Phase tracking

Create this todo list via `TaskCreate` **before doing anything else** so the user can watch progress. Mark each `in_progress` when you start it and `completed` the moment it's done — don't batch.

1. `Scope the topic with the user` — activeForm `Scoping the topic`
2. `Research code` — activeForm `Researching code`
3. `Research history (git log, PRs, issues)` — activeForm `Researching history`
4. `Clarify with user` — activeForm `Clarifying with user`
5. `Plan the page structure` — activeForm `Planning page structure`
6. `Write the HTML` — activeForm `Writing HTML`
7. `Verify and report` — activeForm `Verifying output`

Tasks that turn out to be no-ops (e.g. no clarifications needed) should still be marked completed so the list closes cleanly.

## Step 1 — Scope with the user (only if needed)

If `$ARGUMENTS` is concrete enough to act on (e.g. "auto-failover sigmoid", "the request transformation pipeline"), skip straight to Step 2.

If it's vague ("explain the auth system"), use `AskUserQuestion` to nail down: which sub-area, intended audience (new hire / on-call / external partner), and any specific incident, PR, or thread that prompted the request. Don't ask more than 2 questions here — the rest can come in Step 4.

## Step 2 — Research code

Launch up to 3 `Explore` subagents **in parallel** (single message, multiple tool calls). Use the minimum number that actually fits the scope — one is fine for a narrow topic.

Each agent should return:
- Exact file paths and line ranges for the key implementation.
- Constants, defaults, env vars, feature flags involved.
- Adjacent code worth mentioning (tests that pin behavior, related subsystems).
- The formula / data flow / algorithm in plain terms.

Read the critical files yourself afterward to confirm the agent's claims before citing them. Verify line numbers exist — the page will link to them as permalinks.

## Step 3 — Research history

Use `gh` and `git` to understand *why* the code is the way it is:

- `git log --oneline -- <path>` for the file's commit history (most recent first; cap at ~30).
- `git log -L <start>,<end>:<path>` for the history of the specific lines if narrow.
- `git log --grep=<keyword>` to find related work.
- For each interesting commit, `gh pr list --search <sha>` or `gh api repos/:owner/:repo/commits/<sha>/pulls` to find the introducing PR.
- For each PR: `gh pr view <num> --json title,body,author,mergedAt,url,comments,reviews,closingIssuesReferences`.
- For each linked issue: `gh issue view <num> --json title,body,comments,url`.
- If PRs reference incidents, status pages, or external docs, `WebFetch` them.

You're looking for the *narrative*: what problem prompted this code, what alternatives were rejected, what incidents it was tuned for. This is the part that can't be derived from the current code alone — it's the whole reason this command exists.

## Step 4 — Clarify with the user

Use `AskUserQuestion` to resolve anything that materially affects the page and isn't answerable from research:

- File path / location for the output (default suggestion: `docs/<slug>.html`).
- Scope decisions you're unsure about (cover signal X too, or keep it focused?).
- Whether to include an interactive simulation (sliders, toggles, sample inputs) — only ask if a visualization would genuinely help; static SVG is fine for most topics.
- Anything else where you'd otherwise be guessing.

Cap at 3 questions per round. Skip this step entirely if research left no real ambiguity.

## Step 5 — Plan the page

Sketch (internally, not necessarily to disk) the page's section list before writing. A typical structure:

1. **Eyebrow + h1 + lede** — what this page is, in one sentence.
2. **The problem** — the *why*, grounded in incidents or constraints from Step 3.
3. **The mechanism** — the formula, algorithm, or flow, with code snippets.
4. **The knobs** — constants, env vars, feature flags in a table.
5. **Behavior at sample inputs** — concrete numbers, ideally matching test assertions.
6. **Visualization** — interactive sim or static SVG, only if it adds understanding.
7. **Open questions / tradeoffs** — pulled from PR discussion threads.
8. **References** — every file/line/PR/issue/incident, all linked.

Drop sections that don't apply. Add sections the topic demands. Don't pad.

## Step 6 — Write the HTML

Single self-contained file at the path agreed in Step 4. **Inline CSS, inline JS, no external deps, no build step, no network requests at runtime.**

### Design principles

The visual choices — palette, typography, layout, density — are yours to make based on the subject. A post-mortem of an outage, a tour of a parser, and a guide to a config schema each deserve to look and feel a little different. Pick what serves the topic.

What stays constant:

- **Looks like an internal engineering doc**, not marketing or a product page. No hero images, no decorative gradients, no glossy "card" chrome, no emoji.
- **Restrained.** The styling supports comprehension, not the other way around. If a visual choice isn't pulling its weight, drop it.
- **Code-backed.** Real code snippets in `<pre><code>` blocks, real numbers in tables, real file references — never hand-wavy summaries when the code can speak.
- **Scannable.** Clear hierarchy (eyebrow / h1 / h2 / h3), tabular numerals for numeric columns, generous whitespace between sections.
- **Self-contained at runtime.** Inline CSS and JS, system fonts only, no CDN scripts, no fetch calls. The page must work offline.
- **Mobile-legible.** Single-column at narrow widths, no horizontal overflow on prose.
- **Light mode by default,** unless the subject genuinely calls for something else (e.g. an explainer about a dark-mode UI feature).

If the user has indicated a specific aesthetic, audience, or constraint — in this invocation or in a clarifying answer — that overrides your defaults.

### Syntax highlighting (required)

The page should highlight code in `<pre><code>` blocks. Two acceptable approaches — pick whichever fits the topic:

**Preferred — vendor highlight.js inline.** Download the minified bundle and a theme stylesheet at generation time and paste them straight into the `<head>` so the page stays self-contained at runtime:

```bash
# common-languages bundle (~25 KB minified) covers ~30 popular languages
curl -fsSL https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js
curl -fsSL https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github.min.css
```

If the topic uses unusual languages, fetch the language-specific file too (`languages/<lang>.min.js`) and inline it. Initialize with `hljs.highlightAll()` at the bottom of the page. Pick a theme CSS that harmonizes with the page's overall design (e.g. `github.min.css` for light pages, `github-dark.min.css` for dark).

**Fallback — hand-write a minimal tokenizer.** When highlight.js can't be fetched (offline generation) or the topic is dominated by a single well-known language and you want zero dependency surface, write ~50 lines of JS that tokenize: line/block comments, string literals, numbers, language keywords, type names, and function-call identifiers. Tag each as `<span class="tok-...">` with a small CSS palette that fits the page. Don't try to do anything clever (no semantic analysis, no nested template parsing); a coarse pass is fine.

Either way: highlighting must work offline. No `<script src="https://...">` and no `fetch()` at runtime.

### Permalinks (required)

Every reference to a code file in the page (whether in `<code>` inline, `<span class="src">` source caption, or the References list) should be a clickable link to a github.com permalink at the **current HEAD SHA**. Do NOT hardcode the SHA into prose — use a JS post-processor that scans for the pattern `path/to/file.ext[:start[-end]]` and rewrites matching `<code>` / `<span class="src">` elements into `<a>` tags pointing at:

```
https://github.com/<owner>/<repo>/blob/<SHA>/<path>#L<start>-L<end>
```

Get owner/repo from `git remote get-url origin` and SHA from `git rev-parse HEAD` *before* writing the file. Embed both as constants in the JS. The reference regex from `automode-explainer.html` handles `.go` files; broaden it to whatever extensions the topic involves (`.go`, `.ts`, `.py`, `.rs`, etc.) — but be conservative so unrelated `<code>` content (flag names, function calls, prose) doesn't get linkified by accident.

### Visualizations (when they help)

If the topic has a tunable formula or a state machine, build a small interactive sim:
- Vanilla JS, inline SVG (no chart libraries).
- Sliders use `accent-color: var(--accent)`.
- Show a "current production" baseline as a dashed overlay so the user can compare their tuning against today's behavior.
- Readouts in a small grid below the plot, monospaced, tabular numerals.

If the topic doesn't have anything to tune, skip this. A clean diagram is better than a forced widget.

### Writing voice

Candid, operational, systems-thinking. Concrete over abstract. Cite the code and PR/issues references. Don't editorialize. No marketing energy. No emoji. The audience is engineers who want to be oriented quickly and leave able to reason about tradeoffs.

## Step 7 — Verify and report

- Confirm the file written exists and parses (no broken tags). A quick `grep -c '<script>\|</script>'` should show matched pairs.
- If the page has a simulator, list the expected readout values at known inputs in your final message so the user can spot-check them in a browser.
- Confirm a sample of permalinks resolve to the correct lines (you can `WebFetch` one or two).
- Final message to the user: file path, one-line summary, and any caveats.

## What NOT to do

- Don't create a multi-file build (no React, no Vite, no Tailwind, no npm).
- Don't pull in CDN scripts or fonts (system fonts only — the page must work offline).
- Don't fabricate history. If a PR or issue can't be located, say so rather than inventing context.
- Don't pad the page with generic "what is X" filler the engineer audience already knows.
- Don't commit the file or open a PR — the user will handle that.
