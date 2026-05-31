# Alubys AI Development System

**A complete, reusable AI operating system for project work.**

Gives any AI assistant — Claude, Codex, GPT-4, Gemini — structured memory, workflow modes, and session protocols so it can work on your project with full context, session after session, without re-explaining anything.

> The system treats AI like a structured engineering organization, not a chatbot.

---

## The Problem This Solves

Every AI session starts cold. You re-explain the architecture, re-describe the constraints, re-clarify decisions that were made weeks ago. You waste 20% of every session just re-orienting.

This system fixes that. Project intelligence lives in structured files. The AI reads them at startup and picks up exactly where the last session left off.

---

## What's Inside

```
alubys-ai-dev-system/
├── _GUIDE/                          # Guide and PDF
│   ├── Alubys_AI_Dev_System_Guide.md  # Guide source
│   └── Alubys_AI_Dev_System_Guide.pdf # Pre-built PDF
├── _PROMPTS/                        # AI workflow prompt files
│   ├── MASTER_SYSTEM_PROMPT.md      # Core operating doctrine read by agents
│   ├── START_NEW_PROJECT_PROMPT.md  # First session on a new project
│   ├── ONBOARD_EXISTING_PROJECT_PROMPT.md  # First session on an existing project
│   ├── BRAINSTORMING_MODE_PROMPT.md # Exploration phase
│   ├── PLANNING_MODE_PROMPT.md      # Architecture & roadmap phase
│   ├── EXECUTION_MODE_PROMPT.md     # Execution phase
│   └── REFLECTION_MODE_PROMPT.md    # Review & improve phase
├── AGENTS.md                        # Canonical agent instructions for this repo
├── CLAUDE.md                        # Claude handoff to AGENTS.md
│
├── templates/                       # Copy into your projects
│   ├── AGENTS.md.template           # AI entry point
│   ├── CLAUDE.md.template           # Claude handoff to AGENTS.md
│   ├── README.md.template           # Project readme
│   ├── README.ToBeMerged.md.template # Existing-project README merge suggestions
│   └── .agent/                      # Full memory structure and secret guardrails
│       ├── .gitignore.template      # Ignores local-only secret notes
│       ├── secrets.example.md.template
│       ├── memory/                  # active-context, decisions, lessons, changelog
│       ├── planning/                # brainstorming, spec, architecture, phases
│       ├── tasks/                   # roadmap, backlog, in-progress, completed
│       ├── sessions/                # session logs
│       └── reflections/             # weekly review, agent improvements
│
├── docs/                            # Guides for humans
│   ├── QUICKSTART.md
│   ├── HOW_TO_USE_THIS_SYSTEM.md
│   ├── NEW_PROJECT_WORKFLOW.md
│   ├── EXISTING_PROJECT_WORKFLOW.md
│   ├── MEMORY_RULES.md
│   └── AGENT_CLOSEOUT_PROCESS.md
│
├── scripts/
│   ├── init-new-project.sh          # Bootstrap a new project
│   └── copy-agent-system.sh         # Add to an existing project
└── tests/
    └── test-scripts.sh              # Installer regression tests
```

---

## Quickstart

### New project — Mac / Linux
```bash
cd ~/Projects
bash /path/to/alubys-ai-dev-system/scripts/init-new-project.sh my-project-name
cd my-project-name
```

### New project — Windows (PowerShell)
```powershell
cd C:\Projects
.\path\to\alubys-ai-dev-system\scripts\init-new-project.ps1 my-project-name
cd my-project-name
```

### Existing project — Mac / Linux
```bash
cd my-existing-project
bash /path/to/alubys-ai-dev-system/scripts/copy-agent-system.sh
```

### Existing project — Windows (PowerShell)
```powershell
cd C:\my-existing-project
.\path\to\alubys-ai-dev-system\scripts\copy-agent-system.ps1
```

Open the project with a file-aware AI agent and ask it to follow `AGENTS.md`, then use the relevant prompt file for your workflow.

> **Windows first-time setup:** If PowerShell blocks the script, run this once in PowerShell:
> `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

### Verify the scripts (Mac / Linux)
```bash
bash tests/test-scripts.sh
```

---

## The Four Workflow Modes

| Mode | When to use | Key output |
|------|-------------|------------|
| **Brainstorming** | Starting something new | Problem definition, constraints, risks |
| **Planning** | Ready to design | Architecture, roadmap, backlog |
| **Execution** | Time to execute | Completed work, updated memory |
| **Reflection** | End of phase / weekly | Lessons learned, improved AI behavior |

Project type is discovered during Brainstorming and used during Planning to tailor the product specification, architecture, risks, backlog, and implementation phases. This avoids maintaining separate project-type template variants too early.

---

## Approval Modes

Each project chooses how much the AI may do before asking:

| Mode | Behavior |
|------|----------|
| Plan-First | Full plan and explicit approval before file changes, commands, scripts, installs, moves/deletes, or implementation. |
| Standard | Safe scoped work after orientation; approval before destructive, risky, broad, or external-impact actions. |
| Autonomous | Higher autonomy within scope; approval still required for destructive, external-impact, credential, publishing, deployment, or broad architecture changes. |

The selected mode is recorded in `AGENTS.md` and `.agent/memory/active-context.md`.

---

## How a Session Works

**Start** (30 seconds): A file-aware AI reads `AGENTS.md`, `MASTER_SYSTEM_PROMPT.md`, and the 5 startup files → tells you where the project is → work begins.

**End** (2 minutes): Say "run the closeout protocol" → AI updates 3–5 memory files → lists next steps → session is preserved.

Commit `.agent/` by default, including session summaries. Real secret values belong only in environment variables, a password manager, or `.agent/secrets.local.md`.

Chat-only fallback: if an AI cannot read project files, paste `MASTER_SYSTEM_PROMPT.md`, the relevant startup files, and any setup or mode prompt manually.

---

## Works With Any AI

Claude, Codex, GPT-4, Gemini — the intelligence lives in the files, not in the AI's chat history. Switch models anytime. The new AI reads the same startup files and gets the same context.

---

## Design Principles

- **Lean first** — start with the minimum, grow incrementally
- **Continuity over chat history** — intelligence lives in files
- **Mode discipline** — don't jump from brainstorming to execution
- **Memory hygiene** — lean, accurate memory beats complete, stale memory
- **Don't over-engineer v1** — the system evolves with use

---

## Documentation

- [Full Documentation Site](https://apps.alubys.com/ai-dev-system/) — browse the complete guide online
- [Quickstart](./docs/QUICKSTART.md) — up and running in 10 minutes
- [How to Use This System](./docs/HOW_TO_USE_THIS_SYSTEM.md) — full explanation
- [Memory Rules](./docs/MEMORY_RULES.md) — how to keep memory files effective
- [New Project Workflow](./docs/NEW_PROJECT_WORKFLOW.md) — step by step
- [Existing Project Workflow](./docs/EXISTING_PROJECT_WORKFLOW.md) — step by step
- [Agent Closeout Process](./docs/AGENT_CLOSEOUT_PROCESS.md) — session discipline

---

## Support This Project

The Alubys AI Development System is provided as a free public resource. If it helps you preserve AI memory, organize project work, or work more effectively with AI agents, you are welcome to support continued development and related public tools.

Support can be sent through Zelle by scanning this QR code for **ALUBY'S LLC**:

![Zelle QR code for ALUBY'S LLC](https://github.com/user-attachments/assets/41d9a2b6-0424-4ca8-aedb-d7fc9247f92f)

---

## Legal

This software is provided "as is" by Alubys, LLC without warranty of any kind. Use is entirely at your own risk.

By using this system in any form, you agree to the [Terms of Use](https://alubysllc.github.io/terms), including full assumption of responsibility for all outcomes — data loss, AI token costs, and any consequences of AI-generated content. Alubys, LLC is held harmless from any claims arising from use of this system.

See [DISCLAIMER.md](./DISCLAIMER.md) and [LICENSE](./LICENSE) for details.

---

*Alubys AI Development System — public release package*
