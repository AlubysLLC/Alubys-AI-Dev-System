# Existing Project Workflow
## Alubys AI Development System

> Step-by-step guide for onboarding an existing project into this system.

---

## When to Use This

Use this guide when:
- You have a project that's already started (or even in production)
- You want to add structured AI memory and workflows to it
- You're taking over a project that someone else built
- You want to restart a stalled project with better structure

---

## The Golden Rule

**Inspect before you write. Preserve before you refactor.**

Onboarding is not about cleaning up the project. It's about understanding it and creating the memory structure that will support future sessions. Cleanup is a future task.

---

## Step 1: Copy the System

```bash
# From inside your existing project
bash /path/to/alubys-ai-dev-system/scripts/copy-agent-system.sh
```

This adds the `.agent/` directory structure, `AGENTS.md`, and the Claude handoff file `CLAUDE.md` without overwriting existing files.

If the project already has `AGENTS.md`, `CLAUDE.md`, or `.agent/` memory files, the script skips those files and leaves them unchanged. Review the skipped files manually and merge useful Alubys sections only when they fit the project.

`MEMORY.md` is not part of the public installed system, so the script does not create or modify it.

If the project already has `README.md`, the script creates `README.ToBeMerged.md` with suggested Alubys sections to review and manually merge. If the project has no `README.md`, the script creates a normal `README.md` from the project README template.

Commit `.agent/` by default, including `.agent/sessions/`. The Alubys system depends on durable project memory. Real secret values must not be committed; use environment variables, a password manager, or `.agent/secrets.local.md`, which is ignored by `.agent/.gitignore`.

---

## Step 2: Start the Onboarding Session

Use a file-aware AI agent as the primary workflow. Open the project and say:

> "Follow `AGENTS.md` and use `ONBOARD_EXISTING_PROJECT_PROMPT.md` to onboard this project."

Fallback: if the AI cannot read repository files, paste:

1. `MASTER_SYSTEM_PROMPT.md`
2. `ONBOARD_EXISTING_PROJECT_PROMPT.md`

Say: *"I have an existing project I want to onboard into this system. Please inspect it and document what you find."*

---

## Step 3: The AI Inspects

The AI will:
1. List the directory structure
2. Read existing documentation
3. Identify the tech stack
4. Summarize the architecture
5. Flag technical debt

**Let it run without intervening.** The inspection takes 10–20 minutes for most projects.

---

## Step 4: Review the Generated Documentation

The AI will have created draft versions of:
- `.agent/planning/architecture-proposals.md`
- `.agent/planning/constraints.md`
- `.agent/memory/active-context.md`
- `.agent/tasks/roadmap.md`
- `.agent/tasks/backlog.md`

Review each one:
- Correct anything the AI got wrong
- Add context the AI couldn't infer from the code (business context, history, constraints)
- Fill in gaps where the AI left placeholders

This review is important. The AI's understanding of your project is only as good as what's in the code and docs.

If `README.ToBeMerged.md` was created, review it and merge only the useful sections into the project's main `README.md`.

---

## Step 5: Customize AGENTS.md

Open `AGENTS.md` and fill in:
- Project name and purpose
- Current team and contacts
- Tech stack (verify against what the AI found)
- Key commands (run, test, build, deploy)
- Project-specific rules and constraints

`CLAUDE.md` should stay lean. It exists only to tell Claude to read and follow `AGENTS.md`.

---

## Step 6: Decide the Current Mode

Based on the current state of the project, decide which mode to start in:

| Project State | Start In |
|--------------|----------|
| No clear direction, figuring things out | BRAINSTORMING |
| Direction is clear, haven't designed yet | PLANNING |
| Design is done, building features | EXECUTION |
| Been building for a while, need to reflect | REFLECTION |

Update `active-context.md` with the chosen mode.

---

## Step 7: Run the Closeout Protocol

Even though this was an onboarding session, run the full closeout:
- Confirm memory files are populated
- Add a changelog entry marking the onboarding date
- List the first real next steps

---

## After Onboarding

The project is now in the system. Future sessions start with the standard startup protocol.

Primary workflow for file-aware AI agents:

1. Open the project in the AI assistant
2. Say: "Follow `AGENTS.md`, read the startup files, and tell me where we are."
3. Work begins

Fallback for chat-only tools:

1. Paste `MASTER_SYSTEM_PROMPT.md`
2. Provide the 5 startup files or their contents
3. Say: "Tell me where we are."
4. Work begins

The AI will be oriented in 2–3 minutes, regardless of which AI system you use.

---

## What If the Existing Project Has No Documentation?

This happens often. The AI will work from code inspection alone. The architecture summary it produces will be rougher, and you'll need to fill in more gaps in the review step.

That's okay. An imperfect starting memory file that gets refined over time is far better than no memory system at all.

---

*Alubys AI Development System — Existing Project Workflow v1.0*
