# Memory Files Reference

All project memory lives in the `.agent/` directory inside your project.

---

## Always Read at Startup

These five files are read at the start of every session:

| File | Purpose |
|------|---------|
| `memory/active-context.md` | Current state — mode, phase, next step, blockers. **The most important file.** |
| `tasks/in-progress.md` | What is actively being worked on right now |
| `tasks/roadmap.md` | Where the project is going — high-level milestones |
| `memory/lessons-learned.md` | Rules and patterns discovered during the project |
| `memory/decisions.md` | Architecture and technical decisions with rationale |

---

## Full Memory File Reference

| File | Purpose | Updated When |
|------|---------|-------------|
| `memory/active-context.md` | Current state — mode, phase, next step, blockers | End of every session |
| `memory/decisions.md` | Architecture and technical decisions with rationale | A decision is made |
| `memory/lessons-learned.md` | Rules and patterns discovered during the project | After mistakes or discoveries |
| `memory/changelog.md` | Session-by-session log of what changed | End of every session |
| `planning/brainstorming.md` | Exploratory notes from brainstorming phase | During brainstorming |
| `planning/product-specification.md` | Definitive scope and MVP definition | During planning |
| `planning/architecture-proposals.md` | Tech stack, architecture, data model | During planning |
| `planning/constraints.md` | Hard limits: timeline, budget, tech, compliance | Brainstorming / planning |
| `planning/risks.md` | Known risks and mitigation strategies | Brainstorming, revisit in reflection |
| `planning/implementation-phases.md` | Phased build plan with tasks per phase | During planning |
| `tasks/roadmap.md` | High-level milestones and project direction | At phase completion |
| `tasks/backlog.md` | All known tasks not yet in progress | Continuously |
| `tasks/in-progress.md` | Active tasks only — max 5–7 items | Every session |
| `tasks/completed.md` | Append-only record of finished work | When tasks complete |
| `sessions/README.md` | Log of AI work sessions | End of every session |
| `reflections/weekly-review.md` | Periodic project health review | Weekly or at phase end |
| `reflections/agent-improvements.md` | Observations about AI behavior to improve | During reflection |

---

## What Belongs in Memory Files

**Store:**
- Architecture decisions and their rationale
- Recurring bugs and their root causes
- Deployment caveats and environment quirks
- Important commands and workflows
- Project constraints (performance, legal, business)
- Lessons learned from past mistakes

**Never store:**
- Real secret values, API keys, passwords, or tokens
- Transcript dumps or conversation logs
- Temporary debug output
- Duplicated content that already exists elsewhere
- Stale information that no longer applies

---

## Size Rule

When any memory file exceeds ~200 lines, compress it during Reflection Mode: summarize resolved items, remove stale entries. A bloated memory file is noise, not signal.

---

*See also: [Memory Rules](docs/MEMORY_RULES.md) — [Git & Memory Policy](docs/GIT_AND_MEMORY_POLICY.md)*
