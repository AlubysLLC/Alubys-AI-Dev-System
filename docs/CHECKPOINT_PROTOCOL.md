# Checkpoint Protocol

A Checkpoint saves your session's progress mid-flight without ending the session.

**Use it when:**
- A session is getting long
- Before a risky or complex change
- Any time you want to protect work against context compacting

---

## How to Trigger

Say: **"Run checkpoint."**

---

## What the AI Does

| Step | Action | File Updated |
|------|--------|-------------|
| 1 | Update current phase, what was just done, immediate next steps | `active-context.md` |
| 2 | Move completed sub-tasks to "Just Completed (This Session)" | `in-progress.md` |
| 3 | Append one-line note: date + brief summary of progress | `changelog.md` |

The AI confirms: *"Checkpoint saved."* and continues working.

---

## Checkpoint vs. Closeout

| | Checkpoint | Closeout |
|--|-----------|---------|
| **When** | Mid-session | End of session |
| **Steps** | 3 | 7 |
| **Time** | ~30 seconds | ~2 minutes |
| **Ends session?** | No | Yes |
| **Updates lessons-learned?** | No | Yes |
| **Memory Test?** | No | Yes — mandatory |

> A session with multiple Checkpoints still requires a full Closeout at the end. Checkpoint saves progress — Closeout preserves continuity.

---

*Related: [Closeout Protocol](docs/AGENT_CLOSEOUT_PROCESS.md) — [Startup Protocol](docs/STARTUP_PROTOCOL.md)*
