# Quickstart Guide
## Alubys AI Development System

Get up and running in under 10 minutes.

---

## What You're Getting

A complete AI operating system for project work — structured memory, workflow modes, and protocols that let any AI assistant work on your project with full context, session after session.

---

## For a New Project

> **First time?** [Install the system](docs/INSTALLATION.md) before running these commands.

```bash
# 1. Go to the parent folder where the project should be created
cd ~/Projects

# 2. Create and initialize the project folder
bash ~/Tools/Alubys-AI-Dev-System/scripts/init-new-project.sh my-project

# 3. Open the new folder in your editor / IDE
cd my-project

# 4. Ask your file-aware AI assistant to follow AGENTS.md
#    and use START_NEW_PROJECT_PROMPT.md for setup.

# 5. Begin brainstorming
```

If you already created and entered the project folder, run:

```bash
bash ~/Tools/Alubys-AI-Dev-System/scripts/init-new-project.sh my-project .
```

The AI will guide you through the rest.

---

## For an Existing Project

> **First time?** [Install the system](docs/INSTALLATION.md) before running these commands.

```bash
# 1. Navigate to your existing project
cd my-existing-project

# 2. Copy the Alubys system into it
bash ~/Tools/Alubys-AI-Dev-System/scripts/copy-agent-system.sh

# 3. Ask your file-aware AI assistant to follow AGENTS.md
#    and use ONBOARD_EXISTING_PROJECT_PROMPT.md for onboarding.

# 4. Let the AI inspect and document the project
```

---

## Choose an Approval Mode

During setup or onboarding, choose how much the AI may do before asking:

| Mode | Best for |
|------|----------|
| Plan-First Mode | You want a complete plan and explicit approval before any changes or commands. |
| Standard Mode | You want the AI to proceed with safe scoped work, but ask before risky actions. |
| Autonomous Mode | You want the AI to move faster within scope, while still asking before destructive or external-impact actions. |

The selected mode is recorded in `AGENTS.md` and `.agent/memory/active-context.md`.

---

## Core Prompt Files

| File | When to use |
|------|------------|
| `MASTER_SYSTEM_PROMPT.md` | Core doctrine read from disk by file-aware agents |
| `START_NEW_PROJECT_PROMPT.md` | First session on a new project |
| `ONBOARD_EXISTING_PROJECT_PROMPT.md` | First session on an existing project |
| `BRAINSTORMING_MODE_PROMPT.md` | When exploring a new project or major feature |
| `PLANNING_MODE_PROMPT.md` | When turning discovery into architecture and roadmap |
| `EXECUTION_MODE_PROMPT.md` | When you're building |
| `REFLECTION_MODE_PROMPT.md` | Weekly or at phase completion |

---

## The 5 Files the AI Reads Every Session

These are in `.agent/` inside your project:

| File | Purpose |
|------|---------|
| `.agent/memory/active-context.md` | Where the project is right now |
| `.agent/tasks/in-progress.md` | What's actively being worked on |
| `.agent/tasks/roadmap.md` | Where the project is going |
| `.agent/memory/lessons-learned.md` | Rules and patterns to honor |
| `.agent/memory/decisions.md` | Architecture, operating, and project decisions already made |

Commit `.agent/` by default so project memory survives across machines and sessions. Do not commit real secret values; store them in environment variables, a password manager, or `.agent/secrets.local.md`.

Fallback: if your AI cannot read project files, manually paste `MASTER_SYSTEM_PROMPT.md`, relevant startup files, and any setup or mode prompt needed for the workflow.

---

## The Workflow in One Sentence

Brainstorm the problem → Plan the architecture → Execute incrementally → Reflect to improve → Repeat.

---

## Next Steps

- Read [HOW_TO_USE_THIS_SYSTEM.md](./HOW_TO_USE_THIS_SYSTEM.md) for the full picture
- Read [MEMORY_RULES.md](./MEMORY_RULES.md) to understand how memory works
- Read [NEW_PROJECT_WORKFLOW.md](./NEW_PROJECT_WORKFLOW.md) or [EXISTING_PROJECT_WORKFLOW.md](./EXISTING_PROJECT_WORKFLOW.md) for step-by-step walkthroughs

---

*Alubys AI Development System — Quickstart v1.0*
