# Workflow Modes

The system enforces four distinct phases of work. Stay in the current mode until you explicitly advance.

> **How to switch modes:** For file-aware AI agents, say "Enter [mode name] mode." For chat-only tools, open the corresponding file in `_PROMPTS/`, copy all the text, and paste it into the AI chat.

---

## Mode 1 — Brainstorming

**Use when:** Starting a new project or major feature. Problem space not yet defined.

**Do:**
- Ask open questions and explore approaches
- Surface constraints and risks
- Define MVP scope

**Don't:**
- Write production code
- Make final architectural decisions
- Rush to planning before the problem is understood

**Key files:** `brainstorming.md` `constraints.md` `risks.md`

---

## Mode 2 — Planning

**Use when:** Brainstorming is complete and the problem is well understood.

**Do:**
- Make architectural decisions with rationale
- Define MVP precisely
- Create roadmap and backlog

**Don't:**
- Begin implementation
- Leave decisions ambiguous
- Over-engineer for hypothetical scale

**Key files:** `product-specification.md` `architecture-proposals.md` `roadmap.md` `backlog.md`

---

## Mode 3 — Execution

**Use when:** Planning is approved and it is time to build.

**Do:**
- Work in small reviewable increments
- Update memory files continuously
- Surface unexpected issues immediately

**Don't:**
- Rewrite large sections without authorization
- Skip memory updates
- Change architecture unilaterally

**Key files:** `active-context.md` `changelog.md` `in-progress.md` `completed.md`

---

## Mode 4 — Reflection

**Use when:** End of a phase, after a difficult session, or on a weekly cadence.

**Do:**
- Identify recurring mistakes and root causes
- Surface workflow inefficiencies
- Compress stale memory files

**Don't:**
- Make code changes
- Add features
- Use this as a status update session

**Key files:** `lessons-learned.md` `weekly-review.md` `agent-improvements.md`

---

## Prompt File Reference

| Mode | Prompt File |
|------|------------|
| Any session start | `_PROMPTS/MASTER_SYSTEM_PROMPT.md` |
| First session, new project | `_PROMPTS/START_NEW_PROJECT_PROMPT.md` |
| First session, existing project | `_PROMPTS/ONBOARD_EXISTING_PROJECT_PROMPT.md` |
| Brainstorming | `_PROMPTS/BRAINSTORMING_MODE_PROMPT.md` |
| Planning | `_PROMPTS/PLANNING_MODE_PROMPT.md` |
| Execution | `_PROMPTS/EXECUTION_MODE_PROMPT.md` |
| Reflection | `_PROMPTS/REFLECTION_MODE_PROMPT.md` |

> **Important:** Do not skip Brainstorming. Most AI-assisted projects fail because users jump from idea to code. The structured phases exist to prevent this.
