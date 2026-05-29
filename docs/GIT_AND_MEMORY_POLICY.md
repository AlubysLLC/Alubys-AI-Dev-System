# Git & Memory Policy

---

## What to Commit

**Commit `.agent/` by default**, including `.agent/sessions/`.

The `.agent/` directory is durable project memory. If it is ignored, the project loses continuity across machines, contributors, or system failures. It belongs in version control.

The one exception:

```text
.agent/secrets.local.md
```

This file is ignored by `.agent/.gitignore` and must never be committed.

---

## What Not to Commit

| Item | Reason |
|------|--------|
| `.agent/secrets.local.md` | Contains real secret values — local only |
| Real API keys or passwords | Never in any tracked file |
| `.DS_Store` and OS metadata | Not project data |

---

## The `.agent/` Directory

The `.agent/` directory is intentionally hidden (dot-prefixed) so durable AI memory does not clutter the project root while still remaining part of the tracked project state.

```text
.agent/
├── .gitignore          ← ignores secrets.local.md
├── secrets.example.md  ← placeholder names only, safe to commit
├── memory/
├── planning/
├── tasks/
├── sessions/
└── reflections/
```

---

## Memory File Hygiene

- Keep files lean — a bloated memory file is noise, not signal
- Mark stale decisions as `[DEPRECATED]` rather than leaving them as if active
- Prefer specific, actionable entries over vague observations
- If a memory file grows beyond ~200 lines, compress it during Reflection Mode: summarize resolved items, remove stale entries

---

## Switching Between AI Systems

When handing off between AI systems or contributors:

1. Commit the current `.agent/` state
2. The new AI reads `AGENTS.md` plus the five startup files
3. No re-explanation required — the files carry the context

The intelligence lives in the files, not in any AI's chat history.
