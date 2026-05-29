# What Is This System

## Overview

The Alubys AI Development System is a reusable AI operating system for project work. It gives AI agents durable project context through structured memory files, workflow modes, mode-specific prompts, and installer scripts.

The goal is simple: a new AI session should be able to read the project memory and continue work without relying on chat history.

---

## The Problem It Solves

Every AI session normally starts cold. You re-explain the architecture, re-describe constraints, re-clarify decisions made weeks ago. This system fixes that — project intelligence lives in structured files that any AI reads in minutes and picks up exactly where the last session left off.

---

## The Three Layers

| Layer | What It Is | How to Use It |
|-------|-----------|---------------|
| Operating System | `MASTER_SYSTEM_PROMPT.md` | AI reads from disk, or paste into chat |
| Memory Files | `.agent/` directory in each project | AI reads at startup, updates throughout |
| Mode Prompts | Prompt files in your project root | AI reads from disk, or paste when switching phases |

---

## Core Principles

- **Continuity over chat history** — project intelligence lives in files, not in AI memory
- **Mode discipline** — brainstorming, planning, execution, and reflection are separate workflows
- **Lean memory** — memory should be accurate, concise, and useful to the next session
- **Templates as source of truth** — generated project files come from `templates/`
- **Small safe changes** — evolve projects incrementally
- **Secrets stay local** — tracked files may reference secret names, never real values

---

## Core File Structure

After installation, the system files live in your project root alongside your code:

```text
your-project/
├── _PROMPTS/                        ← all AI workflow prompt files
│   ├── MASTER_SYSTEM_PROMPT.md      ← full AI operating doctrine
│   ├── START_NEW_PROJECT_PROMPT.md
│   ├── ONBOARD_EXISTING_PROJECT_PROMPT.md
│   ├── BRAINSTORMING_MODE_PROMPT.md
│   ├── PLANNING_MODE_PROMPT.md
│   ├── EXECUTION_MODE_PROMPT.md
│   └── REFLECTION_MODE_PROMPT.md
├── AGENTS.md                        ← canonical AI instructions
├── CLAUDE.md                        ← thin pointer to AGENTS.md (for Claude)
└── .agent/                          ← all project memory lives here
    ├── .gitignore
    ├── secrets.example.md
    ├── memory/
    ├── planning/
    ├── tasks/
    ├── sessions/
    └── reflections/
```

`AGENTS.md` is the canonical instruction file for all AI agents. `CLAUDE.md` is intentionally thin — it tells Claude to read and follow `AGENTS.md`. Other AI-specific instruction files follow the same pattern.

---

## Works With Any AI

Claude, Codex, GPT-4, Gemini — the intelligence lives in the files, not in the AI's chat history. Switch models anytime. The new AI reads the same startup files and gets the same context.

---

*Next: [How to Use This System](docs/HOW_TO_USE_THIS_SYSTEM.md)*
