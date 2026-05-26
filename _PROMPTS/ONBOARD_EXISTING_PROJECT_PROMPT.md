# ONBOARD EXISTING PROJECT PROMPT
## Alubys AI Development System — Existing Project Onboarding

> Paste this when adding the Alubys system to an existing project.
> The AI will inspect the codebase first before generating documentation.

---

You are onboarding an existing project into the Alubys AI Development System.

**Core principle: Inspect before writing. Preserve before refactoring.**

---

## STEP 1: CHOOSE APPROVAL MODE

Ask the user to choose an approval mode before inspection or file changes:

1. **Plan-First Mode** — present a complete plan and wait for explicit approval before changing files, moving/deleting files, running commands, executing scripts, installing dependencies, or implementing changes.
2. **Standard Mode** — proceed with safe scoped work after orientation, but ask before destructive, risky, broad, or external-impact actions.
3. **Autonomous Mode** — proceed through implementation and verification within the requested scope, while still asking before destructive actions, external-impact actions, credential handling, publishing, deployment, or broad architecture changes.

Record the selected mode in `.agent/memory/active-context.md` once it exists.

---

## STEP 2: UNDERSTAND THE CURRENT STATE

Before touching any files, do a full inspection:

1. List the top-level directory structure
2. Read the existing README.md (if present)
3. Read any existing CLAUDE.md, AGENTS.md, or documentation files
4. Scan the main source directories to understand the codebase shape
5. Identify the primary technology stack (languages, frameworks, databases)
6. Look for existing tests, CI configuration, and deployment scripts

Do NOT generate documentation yet. Inspect first.

---

## STEP 3: GENERATE AN ARCHITECTURE SUMMARY

Based on the inspection, write a preliminary architecture summary into `.agent/planning/architecture-proposals.md`:

```markdown
# Architecture Summary (Auto-Generated — [DATE])

## Tech Stack
- Language: [detected]
- Framework: [detected]
- Database: [detected]
- Testing: [detected]
- Deployment: [detected]

## Project Structure
[top-level directory overview]

## Key Components
- [Component]: [Purpose]
- [Component]: [Purpose]

## External Integrations
- [Integration]: [Purpose]

## Unknown / Needs Clarification
- [Question 1]
- [Question 2]
```

---

## STEP 4: GENERATE A TECHNICAL DEBT LIST

Inspect for common issues and document in `.agent/planning/constraints.md`:

**Look for:**
- Missing tests or test coverage
- Undocumented functions and modules
- Inconsistent code style or patterns
- Dependencies that are outdated or poorly documented
- Missing environment configuration documentation
- Security concerns (hardcoded secrets, missing input validation, etc.)
- Build or deployment process gaps

Be honest. Technical debt is better known than hidden.

---

## STEP 5: BUILD THE INITIAL ROADMAP

Ask the user:

1. **What is the current state of this project?** (Active development / Maintenance / Needs rework / Unclear)
2. **What needs to happen next?** What's the immediate priority?
3. **What's broken or blocked right now?**
4. **What are the top 3 things that would move this project forward the most?**

From these answers and the inspection, create:
- `.agent/tasks/roadmap.md` — overall direction
- `.agent/tasks/backlog.md` — list of known tasks
- `.agent/tasks/in-progress.md` — anything actively being worked on

---

## STEP 6: POPULATE ACTIVE CONTEXT

Write `.agent/memory/active-context.md`:

```markdown
# Active Context
Project: [NAME]
Status: Onboarding complete
Date Onboarded: [TODAY]
Current Mode: [BRAINSTORMING / PLANNING / EXECUTION — based on project state]
Approval Mode: [Plan-First / Standard / Autonomous]
Current Focus: [What needs to happen next]

## Current State Summary
[2–3 sentences on where the project is right now]

## Immediate Priority
[What the next session should focus on]

## Known Risks / Blockers
[Any risks or blockers identified during onboarding]
```

---

## STEP 7: STABILITY RULE

**Do not refactor, reorganize, or rewrite anything in this session.**

The goal of onboarding is to:
1. Understand what exists
2. Document it accurately
3. Create a stable foundation for future sessions

If you see things that should be improved, record them in the backlog. Do not act on them now.

---

## STEP 8: CLOSE OUT

Run the standard closeout protocol:
1. Confirm all `.agent/` memory files are populated
2. Update `active-context.md` with what was done
3. Add a `changelog.md` entry for the onboarding
4. List recommended first steps for the next session

Say: *"Onboarding complete. I've documented the current architecture, identified technical debt, and created the initial roadmap. The project is ready to continue in [recommended mode]."*

---

*Alubys AI Development System — Onboard Existing Project Prompt v1.0*
