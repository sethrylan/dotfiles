---
name: slack-reader
description: Read Slack channels, export threads as markdown, and analyze conversations. Use when the user asks about reading Slack messages, exporting Slack threads, summarizing channel activity, or doing Q&A over Slack conversations.
---

# Slack Reader

Read Slack channels and threads using the `slack-reader` CLI. Supports listing channels, reading messages, exporting threads as markdown, and interactive analysis of conversations.

## Prerequisites

### Installation

Verify `slack-reader` is available:

```bash
which slack-reader
```

If not installed:

```bash
go install github.com/sethrylan/slack-reader@latest
```

See https://github.com/sethrylan/slack-reader for details.

### Authentication

Uses cookie-based auth from the local Slack Desktop app. Import credentials once per workspace:

```bash
slack-reader auth creds --workspace github
```

Verify:

```bash
slack-reader auth whoami --workspace github
```

## Default Workspace

Use `--workspace github` by default unless the user specifies a different workspace.

## Commands

### List Channels

```bash
# Current user's channels
slack-reader channel list --workspace github

# Specific user's channels
slack-reader channel list --workspace github --user "@alice" --limit 50

# All workspace channels
slack-reader channel list --workspace github --all --limit 100
```

### List Messages

```bash
# Recent messages in a channel
slack-reader message list "#general" --workspace github

# With a limit
slack-reader message list "#general" --workspace github --limit 50

# As markdown (preferred for analysis)
slack-reader message list "#general" --workspace github --output markdown
```

### Read a Thread

```bash
# All messages in a thread by root timestamp
slack-reader message list "#general" --workspace github --ts "1770165109.628379"

# Thread as markdown
slack-reader message list "#general" --workspace github --ts "1770165109.628379" --output markdown
```

Timestamps accept both `1770165109.628379` (canonical) and `1770165109628379` (concatenated) formats.

### Get a Single Message

```bash
slack-reader message get "#general" --workspace github --ts "1770165109.628379"
```

Channel names (e.g., `#general`) and channel IDs (e.g., `C01ABCDEF`) both work.

## Workflows

### Export a Thread as Markdown

When the user wants to export or save a thread:

1. Get the thread root timestamp (ask the user, or find it from recent messages)
2. Export with `--output markdown`:

```bash
slack-reader message list "#channel" --workspace github --ts "<timestamp>" --output markdown
```

3. Present the markdown output directly, or save to a file if requested

### Export Recent Channel Messages

```bash
slack-reader message list "#channel" --workspace github --limit 50 --output markdown
```

### Analyze Conversations

When the user wants to analyze, summarize, or ask questions about Slack messages:

1. Fetch the relevant messages using `--output markdown` for readability or JSON for structured data:

```bash
# For readable context
slack-reader message list "#channel" --workspace github --output markdown --limit 100

# For structured analysis
slack-reader message list "#channel" --workspace github --limit 100
```

2. Use the fetched content to answer questions. Common analyses:
   - **Summarize** a thread or channel activity
   - **Extract action items** or decisions from a discussion
   - **Identify participants** and their positions
   - **Find specific topics** mentioned in the conversation
   - **Timeline** of how a discussion evolved

### Find a Thread

If the user references a thread but doesn't have the timestamp:

1. List recent messages to find the thread root:

```bash
slack-reader message list "#channel" --workspace github --limit 20 --output markdown
```

2. Identify the relevant message and use its timestamp for thread operations

## Output Formats

| Flag | Format | Best for |
|------|--------|----------|
| *(default)* | JSON | Structured analysis, piping to `jq` |
| `--output markdown` | Markdown | Reading, exporting, summarizing |

## Troubleshooting

- **Auth errors**: Re-run `slack-reader auth creds --workspace github` (requires Slack Desktop to be running)
- **Channel not found**: Try the channel ID instead of the name; list channels to verify
- **No messages returned**: Check `--limit` value; default is unlimited (`0`) for message list
