# START NEW PROJECT PROMPT
## Alubys AI Development System — New Project Initialization

> Paste this when starting a brand-new project. Use after copying the `.agent/` template structure into your new repo.

---

You are starting a new project using the Alubys AI Development System.

## STEP 1: CONFIRM SETUP

Before anything else, verify:
- [ ] The `.agent/` directory structure has been copied into this project
- [ ] `AGENTS.md`, `CLAUDE.md` (or equivalent) are present at the root
- [ ] No prior memory files exist (this is a clean start)

If the structure is not yet in place, stop and run `scripts/init-new-project.sh <project-name>` from the parent directory where the project should be created. If you already created and entered the project folder, run `scripts/init-new-project.sh <project-name> .` to initialize the current directory.

---

## STEP 2: READ THE MASTER SYSTEM PROMPT

Read `MASTER_SYSTEM_PROMPT.md` now and confirm you understand:
- The four workflow modes (Brainstorming → Planning → Execution → Reflection)
- The approval modes
- The startup and closeout protocols
- The memory rules

---

## STEP 3: CHOOSE APPROVAL MODE

Ask the user to choose an approval mode before any implementation work begins:

1. **Plan-First Mode** — present a complete plan and wait for explicit approval before changing files, moving/deleting files, running commands, executing scripts, installing dependencies, or implementing changes.
2. **Standard Mode** — proceed with safe scoped work after orientation, but ask before destructive, risky, broad, or external-impact actions.
3. **Autonomous Mode** — proceed through implementation and verification within the requested scope, while still asking before destructive actions, external-impact actions, credential handling, publishing, deployment, or broad architecture changes.

Record the selected mode in `.agent/memory/active-context.md`.

---

## STEP 4: INITIALIZE MEMORY FILES

Create the following files with minimal starter content:

**`.agent/memory/active-context.md`**
```
# Active Context
Project: [PROJECT NAME]
Status: Brainstorming
Date Started: [TODAY]
Current Mode: BRAINSTORMING
Approval Mode: [Plan-First / Standard / Autonomous]
Current Focus: Initial project definition
```

**`.agent/tasks/roadmap.md`**
```
# Roadmap
Status: Not yet defined — currently in Brainstorming mode
```

**`.agent/tasks/in-progress.md`**
```
# In Progress
- [ ] Complete brainstorming phase
- [ ] Define MVP scope
```

---

## STEP 5: ENTER BRAINSTORMING MODE

You are now in **BRAINSTORMING MODE**. Do not write code. Do not make final decisions.

Ask the user the following questions (one at a time, conversationally):

1. **What are we building?** Describe it in one sentence.
2. **Who is it for?** Who are the primary users?
3. **What problem does it solve?** What's the pain point?
4. **What does success look like?** What does a successful version 1 achieve?
5. **What are the constraints?** Timeline, budget, technology preferences, must-haves vs. nice-to-haves?
6. **What's the MVP?** If you had to ship in 2 weeks, what would you cut?
7. **What are you most uncertain about?** Technical risks, user behavior unknowns, integration complexity?

Capture responses in `.agent/planning/brainstorming.md` as you go.

---

## STEP 6: SURFACE CONSTRAINTS AND RISKS

Before moving to planning, document in `.agent/planning/constraints.md` and `.agent/planning/risks.md`:

**Constraints to explore:**
- Technical constraints (existing stack, hosting, languages)
- Timeline constraints
- Team size and skill constraints
- Budget constraints
- Integration constraints (must work with X)

**Risks to surface:**
- Technical unknowns
- Dependency risks
- Scope creep risk
- User adoption risks

---

## STEP 7: ADVANCE TO PLANNING MODE (when ready)

When the problem space is adequately explored and the user is ready to plan:

Say: *"We have a solid understanding of the problem space. I recommend we advance to PLANNING MODE to define the architecture and roadmap. Ready to proceed?"*

Do NOT advance without explicit user confirmation.

---

*Alubys AI Development System — Start New Project Prompt v1.0*
