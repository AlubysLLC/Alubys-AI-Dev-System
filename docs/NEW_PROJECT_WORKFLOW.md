# New Project Workflow
## Alubys AI Development System

> Step-by-step guide for starting a brand new project with this system.

---

## Before You Start

You need:
- [ ] The system installed on your machine — see [Installation](docs/INSTALLATION.md) if you haven't done this yet
- [ ] A parent folder where your new project should be created
- [ ] An AI assistant (Claude, Codex, GPT-4, etc.)

---

## Step 1: Initialize the Project

```bash
# Go to the parent folder where the project should be created
cd ~/Projects

# Create and initialize the project folder
bash ~/Tools/Alubys-AI-Dev-System/scripts/init-new-project.sh my-new-project

# Enter the initialized project
cd my-new-project
```

This creates the `.agent/` directory structure, copies the root templates (`AGENTS.md` and the Claude handoff `CLAUDE.md`), and initializes empty memory files.

If you already created and entered the project folder, initialize the current directory explicitly:

```bash
bash ~/Tools/Alubys-AI-Dev-System/scripts/init-new-project.sh my-new-project .
```

---

## Step 2: Customize Root Templates

Open `AGENTS.md` and fill in:
- Project name
- Project purpose (1–2 sentences — even if rough)
- Primary AI system you'll use
- Tech stack (if known — leave blank if not)

Keep everything else as template text for now.

---

## Step 3: Start Your First Session

Use a file-aware AI agent as the primary workflow. Open the project and say:

> "Follow `AGENTS.md` and use `START_NEW_PROJECT_PROMPT.md` to start this project."

Fallback: if the AI cannot read repository files, paste:

1. `MASTER_SYSTEM_PROMPT.md` (the operating system)
2. `START_NEW_PROJECT_PROMPT.md` (the new project guide)

Say: *"I want to start a new project. Let's begin with brainstorming."*

---

## Step 4: Brainstorming Phase

The AI will ask you questions about:
- What kind of project this is
- What you're building
- Who it's for
- What problem it solves
- What success looks like
- What constraints exist

Answer honestly. Vague answers produce vague plans. The AI captures everything in `.agent/planning/brainstorming.md`.

**This phase is done when:**
- The project type/shape is clear enough to guide planning
- The problem is clearly defined
- The MVP scope is understood (at least roughly)
- The major constraints are documented
- The key risks are identified

**Time estimate**: 1–3 sessions depending on project complexity

---

## Step 5: Planning Phase

When brainstorming is complete, paste `PLANNING_MODE_PROMPT.md`.

The AI will produce:
- Product specification
- Architecture decision
- Implementation phases
- Initial roadmap and backlog

Planning should tailor these outputs to the project type discovered during Brainstorming. For example, an API service needs API contracts and versioning; a data pipeline needs freshness, validation, and monitoring; an AI agent needs tool-access boundaries and evaluation criteria.

Review each document. Push back if something doesn't seem right. This is your chance to catch problems before they're built.

**This phase is done when:**
- You've approved the architecture
- The MVP scope is locked
- The backlog has enough tasks for the first 2–3 sessions

**Time estimate**: 1–2 sessions

---

## Step 6: Execution Phase

When planning is approved, paste `EXECUTION_MODE_PROMPT.md`.

The AI builds the project incrementally:
- One task at a time
- Updates memory files as it goes
- Surfaces unexpected issues rather than hiding them

**Cadence**: Run Reflection Mode every 1–2 weeks, or at the end of each phase.

---

## Step 7: Reflection Phase

When a phase completes (or weekly, whichever is sooner), paste `REFLECTION_MODE_PROMPT.md`.

The AI:
- Identifies what went well and what didn't
- Captures lessons into `lessons-learned.md`
- Updates `agent-improvements.md` with behavior changes
- Prunes stale content from memory files

Then continue to the next execution phase.

---

## Timeline Example

| Week | Activity |
|------|----------|
| Week 1 | Brainstorming (2–3 sessions) |
| Week 1–2 | Planning (1–2 sessions) |
| Week 2–6 | Execution Phase 1 |
| Week 6 | Reflection |
| Week 7–10 | Execution Phase 2 |
| Week 10 | Reflection |
| ... | ... |

---

*Alubys AI Development System — New Project Workflow v1.0*
