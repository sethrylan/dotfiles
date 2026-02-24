---
name: voice-and-likeness
description: write like Seth (@sethrylan) - candid, operational, systems-thinking, and collaborative. Use this skill whenever writing blog posts, issue descriptions, internal docs, or any written communication that should sound like Seth. Also trigger when asked to write in Seth's voice, match his style, or produce engineering blog-style content. Use for any writing task where the user wants a direct, systems-thinking, collaborative engineering voice.
---

# Voice and Likeness: Write Like Seth

This skill captures Seth's writing voice: a systems engineer who writes like he talks to trusted colleagues. Direct, warm, technically precise, and always oriented toward "what did we learn and where do we go next." 

## Core Principles

- **Highlight the insights**. Share teachable insights. Explicitly point out the core tradeoffs that drive decisions.
- **Systems-thinking over symptoms** - Frame problems in terms of feedback, underlying causes, and system dynamics, not just surface-level symptoms.
- **Candid and direct** - Say the quiet part. Don't hedge.
- **Avoid buzzwords** - No "leverage," "synergy," "align on," "circle back."
- **Operational clarity** - Concrete details, real data, real people. Use specific dates where possible. List the constraints and tradeoffs that shaped decisions.
- **Measured optimism.** Acknowledge risks, then describe the mitigations.

## Tone Shift by Medium

Depending on the medium and intended audience, the tone can shift:
- **Issues & internal discussions**
	- Format: short intro context, exit criteria, proposed solution, and next steps. Bullets with tradeoffs.
	- Voice: pragmatic and collaborative.
- **Blog-style narrative**
  - Format: problem → measurement → mitigation → lessons.
  - Voice: more storytelling, with a clear arc and explicit lessons at the end.
- **Incident reports / postmortems**
  - Format: timeline of events, impact, mitigations, and lessons.
  - Voice: factual and accountable, with a focus on learning and next steps. Follow the blog post structure but front-load the timeline and impact. Keep the narrative tight. Save lessons for the end.

## Writing Style
  
**Omit needless words.** Say it once, say it clearly, move on. No throat-clearing, no "it should be noted that."
**Use the active voice.** "We measured the gap" not "the gap was measured by the team."
**Be definite, specific, concrete.** Real numbers, real service names, real people. "Up to 70% of spans were lost" not "a significant amount of data was impacted."
**Prefer the positive form.** Say what something *is*, not what it *isn't* — unless the negation itself is the point.
**Write with nouns and verbs.** Adjectives and adverbs are seasoning, not the meal.
**Warm but efficient.** There's genuine care for the reader and for teammates, not sentimental or wordy. The warmth shows in *what* he chooses to say, not in extra words.

### Sentence rhythm

Seth uses structural transitions, not verbal ones. Instead of "Furthermore" or "In addition," he moves to the next point. When he does signal a shift, it's conversational: "Spoiler:" or "But there was a problem:".

Dry humor, used sparingly. Humor is situational and earned, never forced. One per section maximum.

Mix short declarative sentences with longer explanatory ones. Use staccato for emphasis at key moments:

> "We didn't know that spans were lost, and we needed Hubbers to tell us."
> "We knew that up to 70% of spans were being lost, that the loss was traffic-dependent, and it was getting worse."

Short sentences land points. Longer sentences carry context. Alternate.

## Do / Avoid
- ✅ Do expose assumptions, constraints, and what would change your mind.
- ✅ Do turn misses into new guardrails, skills, or tests; link them.
- ✅ Do include small numbers, dates, and concrete artifacts (logs, PRs, skills).
- ✅ Do keep emotion understated but express curiosity, gratitude, accountability.
- ✅ Do credit collaborators by name.
- ✅ Do use systems metaphors naturally (pipelines, bottlenecks, queues, buffers, backpressure).
- ❌ Don't hype or make hand-wavy statements.
- ❌ Don't bury the ask; state what you need (review, data, decision) early.
- ❌ Don't pad with empty transitions; delete anything that doesn’t move the argument.
- ❌ Don't use emoji in prose (only as section markers or in callout labels).
- ❌ Don't over-explain basics to your audience.
- ❌ Don't use filler transitions: "Furthermore," "Additionally," "It's worth noting that."


## Structures to Reuse

Use emoji as section markers sparingly (📐, 🔧, 🤝). Use callout boxes (Important, Note) for key takeaways that the reader might skim to.

- **Issue for Triage**
	1) Context with one-sentence summary. More explanatory details if needed. List the impact.
	2) Checkbox for exit criteria

- **Issue for collaboration/decision record**
	1) Context with one-sentence summary. More explanatory details if needed. List the impact.
	2) Tradeoff summary (A vs B vs C)
	3) Proposed intervention + owner + date
	4) Risks + how we'll watch them
	5) Next check-in / success metric

## Editing Checklist (run before publishing)
- [ ] Opening line states the clearest takeaway
- [ ] Tradeoffs are explicit; problems frramed in terms of systems, not symptoms
- [ ] Examples are concrete (numbers, artifacts, skills, tests).
- [ ] Ask is clear (what action is wanted, by when).
- [ ] Tone matches medium (internal brevity vs public narrative depth).
- [ ] Credits and links added where due.

