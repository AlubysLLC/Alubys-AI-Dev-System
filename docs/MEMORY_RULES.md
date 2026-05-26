# Memory Rules
## Alubys AI Development System

> How to keep memory files lean, accurate, and useful.
> Good memory is the foundation of good continuity. Bad memory is worse than no memory.

---

## The Goal

Memory files exist to give the next AI session a running start. They should answer the question: *"If an experienced engineer joined this project today and had 5 minutes to read, what would they most need to know?"*

If your memory files can't answer that question concisely, they need work.

---

## What Belongs in Memory

### YES — Put these in memory files

| Content | Where |
|---------|-------|
| Architecture decisions and why they were made | `decisions.md` |
| Bugs that recurred more than once, with root cause | `lessons-learned.md` |
| Deployment quirks and environment caveats | `lessons-learned.md` |
| Commands and workflows the AI needs to know | `AGENTS.md` |
| Current project state and immediate next step | `active-context.md` |
| Project constraints (technical, business, timeline) | `constraints.md` |
| User/owner preferences and working style | `AGENTS.md` |
| Decisions that were reversed (mark as SUPERSEDED) | `decisions.md` |

### NO — Never put these in memory files

| Content | Why not |
|---------|---------|
| Real secret values, API keys, passwords, tokens | Security — ever |
| Chat transcripts or conversation logs | Too long, low signal |
| Temporary debug output | Not useful after the session |
| Duplicated content from other files | Creates drift and confusion |
| Information that's no longer true | Actively harmful |
| "Maybe later" ideas without a plan | Put in backlog, not memory |
| Boilerplate that came from a template | Remove it when unused |

---

## Memory Hygiene Rules

### Rule 1: active-context.md is always current
This file must reflect the project's actual current state after every session. A stale active-context.md destroys continuity more than any other single mistake.

**Check**: Does it tell someone joining cold exactly where the project is and what to do next?

### Rule 2: Lean is better than complete
A 500-line memory file that's 90% accurate is less useful than a 100-line file that's 100% accurate. When in doubt, cut.

### Rule 3: Compress on schedule
When any memory file exceeds ~200 lines, compress it:
- Summarize resolved items into 1-line notes
- Remove truly stale entries
- Consolidate near-duplicate lessons
- Mark superseded decisions as `[SUPERSEDED]`

Do this during Reflection Mode.

### Rule 4: Prefer rules over stories
Instead of: *"In the March 15 session we tried to deploy and the environment variables weren't set correctly and it failed for 2 hours..."*

Write: *"Rule: Always verify environment variables are set before deployment. Check with `env | grep APP_` on the server."*

The AI doesn't need the story. It needs the rule.

### Rule 5: Archive superseded content, don't delete it
When a decision is reversed or an approach is abandoned, don't delete the entry. Mark it `[SUPERSEDED]` and note what replaced it. This prevents the same bad decision from being made twice.

### Rule 6: Never put real secrets in tracked files
Do not put real secret values in memory files, session notes, comments, changelogs, examples, or screenshots. Use placeholder names like `[YOUR_API_KEY]` or reference environment variable names only.

It is safe to reference a secret by name:
- `Uses STRIPE_API_KEY from the deployment environment`
- `Database password is stored in the password manager`
- `Local-only setup details are in .agent/secrets.local.md`

Real values belong in environment variables, a password manager, or `.agent/secrets.local.md`. The local file is ignored by `.agent/.gitignore`.

Commit `.agent/` by default, including `.agent/sessions/`. The point of this system is durable project memory. Only real secret values should stay local.

---

## Memory File Sizes (Guidelines)

| File | Target | Max before compress |
|------|--------|---------------------|
| `active-context.md` | 1 page | 2 pages |
| `decisions.md` | Grows with project | 300 lines |
| `lessons-learned.md` | Grows with project | 250 lines |
| `changelog.md` | Append-only | No limit |
| `roadmap.md` | 1–2 pages | 3 pages |
| `in-progress.md` | 5–7 active items | 10 items |

---

## The Memory Test

Before ending a session, ask: *"If I start a new chat right now and paste the startup files, will the AI know exactly where we are and what to do next?"*

If yes: session complete.
If no: update the files until the answer is yes.

---

*Alubys AI Development System — Memory Rules v1.0*
