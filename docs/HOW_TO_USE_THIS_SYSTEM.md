# How to Use the Alubys AI Development System

## The Core Idea

Most AI-assisted development fails for the same reason: the AI has no memory. Every session starts cold. You re-explain the architecture, re-describe the constraints, re-clarify the decisions that were already made. You waste 20% of every session just re-orienting.

This system fixes that. It externalizes the project's intelligence into structured files that any AI can read in minutes. The AI picks up where the last session left off. Decisions are preserved. Mistakes are not repeated. Progress accumulates.

---

## How It Works

The system has three layers:

**1. The Operating System** — `MASTER_SYSTEM_PROMPT.md`
This is the doctrine. File-aware AI agents read it from the project through `AGENTS.md`. It defines what phases exist, what rules to follow, when to update memory, how to close out a session.

**2. The Memory Files** — `.agent/` directory in each project
This is the project's long-term context. The AI reads these files at startup and updates them throughout the session. They capture architecture decisions, active tasks, lessons learned, and current state.

Commit `.agent/` to version control by default, including `.agent/sessions/`. Real secret values are the exception: reference secret names only, and keep actual values in environment variables, a password manager, or `.agent/secrets.local.md`.

**3. The Workflow Prompts** — setup prompts plus four mode prompts in the project root
The setup prompts guide new-project initialization and existing-project onboarding. The four mode prompts guide brainstorming, planning, execution, and reflection. Paste the relevant prompt when you want to enter that workflow.

The files created by the setup scripts come from `templates/`. If generated project files need to change, update the template first; the scripts should only render templates and copy prompt files.

Run `bash tests/test-scripts.sh` after changing installer scripts or templates.

`Alubys_AI_Dev_System_Guide.md` is the source for the human-readable guide. `Alubys_AI_Dev_System_Guide.pdf` should be regenerated from it only after content is final.

---

## Approval Modes

Each project should choose an approval mode during new-project setup or existing-project onboarding.

| Mode | Behavior |
|------|----------|
| Plan-First Mode | The AI presents a complete plan and waits for explicit approval before changing files, moving/deleting files, running commands, executing scripts, installing dependencies, or implementing changes. |
| Standard Mode | The AI proceeds with safe scoped work after orientation, but asks before destructive, risky, broad, or external-impact actions. |
| Autonomous Mode | The AI proceeds through implementation and verification within the requested scope, while still asking before destructive actions, external-impact actions, credential handling, publishing, deployment, or broad architecture changes. |

Record the chosen mode in `AGENTS.md` and `.agent/memory/active-context.md` so future sessions honor it immediately.

Regardless of mode, the AI should always ask before deleting data/files, overwriting user work, changing git history, publishing/deploying, handling real secrets, or making broad architecture/product-direction changes.

---

## The Four Modes

### Brainstorming Mode
Use when starting a new project or major feature. The AI helps you think — it asks questions, surfaces constraints and risks, explores options. It does NOT write code in this mode. This separation is intentional: it forces you to understand the problem before solving it.

### Planning Mode
Once the problem space is understood, planning converts ideas into a concrete architecture, roadmap, and backlog. By the end of this mode, you have a document that could brief any developer (human or AI) on what to build and how.

### Execution Mode
The building phase. The AI works incrementally, one logical task at a time, updating memory files as it goes. No uncontrolled rewrites. No scope creep without discussion.

### Reflection Mode
Periodic review of what happened. What went wrong, what worked, what the AI should do differently next time. This is how the system gets smarter over time.

---

## Memory File Hierarchy

Not all memory files are equal. Here's how they're prioritized:

**Always read at startup:**
- `active-context.md` — current project state (the most important file)
- `in-progress.md` — what's actively being worked on
- `roadmap.md` — where the project is going
- `lessons-learned.md` — rules to honor
- `decisions.md` — architectural decisions already made

**Read when relevant:**
- `architecture-proposals.md` — system design (when building new components)
- `brainstorming.md` — original thinking (when clarifying scope)

**Updated during sessions:**
- `active-context.md` — after any significant state change
- `changelog.md` — at session end
- `in-progress.md` — as tasks complete

---

## Starting a Session (30 seconds)

Primary workflow for file-aware AI agents:

1. Open your project
2. Open your AI assistant
3. Say: "Follow `AGENTS.md`, read the startup files, and tell me where we are."
4. The AI reads `MASTER_SYSTEM_PROMPT.md` and the 5 startup files, then gives you a 1-paragraph status update
5. Work begins

Fallback for chat-only tools:

If an AI cannot read repository files, manually paste `MASTER_SYSTEM_PROMPT.md`, relevant startup files, and any setup or mode prompt needed for the current workflow.

1. Paste `MASTER_SYSTEM_PROMPT.md`
2. Paste any setup or mode prompt needed for the current workflow
3. Provide the 5 startup files or their contents
4. The AI summarizes status before work begins

---

## Ending a Session (2 minutes)

1. Say: "Run the closeout protocol."
2. The AI summarizes what was done, updates 3–5 files, and lists next steps
3. Everything is captured. The next session starts informed.

---

## Working Across Multiple AI Systems

This system works with any AI. Claude, Codex, GPT-4, Gemini — it doesn't matter.

When switching AI systems:
- The new AI reads the same startup files
- It gets the same context
- It follows the same protocols
- No re-explanation required

The intelligence lives in the files, not in the AI's chat history.

---

## Common Mistakes to Avoid

**Skipping the startup protocol**: The AI starts cold and gives you irrelevant suggestions. Always run startup.

**Skipping the closeout protocol**: The session's work evaporates. The next session re-discovers things you already learned. Always close out.

**Staying in Execution Mode too long without Reflection**: Technical debt accumulates silently. Run Reflection at least once a week on active projects.

**Storing everything in active-context.md**: This file should be lean (1 page). Detailed content belongs in decisions.md, lessons-learned.md, etc. Active-context.md is a status summary, not a knowledge dump.

**Filling out every template on Day 1**: Start with the minimum. active-context.md, in-progress.md, roadmap.md. Everything else grows as you discover things. Over-documentation up front becomes a maintenance burden.

---

*Alubys AI Development System — How to Use v1.0*
