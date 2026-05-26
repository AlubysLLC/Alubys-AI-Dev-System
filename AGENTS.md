# Alubys AI Development System

## Project Purpose

This public repository packages the reusable Alubys AI Development System: prompts, templates, documentation, scripts, and tests for adding durable AI memory and workflow discipline to project work.

The system treats AI like a structured engineering collaborator, not a chatbot.

---

## Public Repository Scope

This repository contains the reusable system, not a specific project's private working memory.

Included:
- Public prompt files
- Public documentation
- Installer scripts
- Regression tests
- `templates/`, including the `.agent/` memory templates copied into target projects

Not included:
- Root `.agent/` working memory for this repository
- Private handoff notes
- Real secrets or local-only project notes

---

## Canonical Agent Instructions

`AGENTS.md` is the canonical instruction file for all AI agents working in this repository.

Claude may also read `CLAUDE.md`, but `CLAUDE.md` only points back here. Do not duplicate core instructions across agent-specific files.

For file-aware AI tools such as Claude Code, Codex, Cursor, or other agents with repository access, this file is the normal entry point. Read and follow `_PROMPTS/MASTER_SYSTEM_PROMPT.md` from disk instead of asking the user to paste it manually.

Fallback for chat-only tools: if the AI cannot read repository files, the user must paste `_PROMPTS/MASTER_SYSTEM_PROMPT.md`, relevant startup files, and any setup or mode prompt manually. This is a compatibility path, not the primary workflow.

---

## Checkpoint Protocol

Say **"run checkpoint"** at any point mid-session to save progress without ending the session. The AI updates `active-context.md`, `in-progress.md`, and appends a one-line note to `changelog.md`, then continues working.

Use Checkpoint on long sessions, before risky changes, or any time you want to protect against context compacting. A Checkpoint does not replace the Closeout — always run Closeout at the end of the session.

---

## Working Protocol

When maintaining this public repository:

1. Read `README.md` for the user-facing product overview.
2. Read `MASTER_SYSTEM_PROMPT.md` for the full operating doctrine.
3. Read `Alubys_AI_Dev_System_Guide.md` before changing guide or PDF content.
4. Treat `templates/` as the source of truth for generated project files.
5. Keep installer scripts thin: render templates, copy prompts, and avoid duplicating generated file bodies inline.
6. Keep docs, prompts, templates, scripts, and tests aligned.
7. Run `bash tests/test-scripts.sh` after changing scripts or templates.
8. Do not add root `.agent/` working memory to the public release package.

---

## Current File Structure

```text
alubys-ai-dev-system/
├── _GUIDE/
│   ├── Alubys_AI_Dev_System_Guide.md
│   └── Alubys_AI_Dev_System_Guide.pdf
├── _PROMPTS/
│   ├── MASTER_SYSTEM_PROMPT.md
│   ├── START_NEW_PROJECT_PROMPT.md
│   ├── ONBOARD_EXISTING_PROJECT_PROMPT.md
│   ├── BRAINSTORMING_MODE_PROMPT.md
│   ├── PLANNING_MODE_PROMPT.md
│   ├── EXECUTION_MODE_PROMPT.md
│   └── REFLECTION_MODE_PROMPT.md
├── AGENTS.md
├── CLAUDE.md
├── templates/
│   ├── AGENTS.md.template
│   ├── CLAUDE.md.template
│   ├── README.md.template
│   ├── README.ToBeMerged.md.template
│   └── .agent/
│       ├── .gitignore.template
│       ├── secrets.example.md.template
│       ├── memory/
│       ├── planning/
│       ├── tasks/
│       ├── sessions/
│       └── reflections/
├── docs/
├── scripts/
│   ├── init-new-project.sh
│   ├── copy-agent-system.sh
│   └── build-guide-pdf.sh
└── tests/
    └── test-scripts.sh
```

---

## Workflow Modes

| Mode | Prompt File | Purpose |
|------|-------------|---------|
| Brainstorming | `_PROMPTS/BRAINSTORMING_MODE_PROMPT.md` | Explore problem space, no implementation |
| Planning | `_PROMPTS/PLANNING_MODE_PROMPT.md` | Architecture, roadmap, backlog |
| Execution | `_PROMPTS/EXECUTION_MODE_PROMPT.md` | Incremental implementation |
| Reflection | `_PROMPTS/REFLECTION_MODE_PROMPT.md` | Learn, improve, compress memory |

---

## Git And Memory Policy

- Public release packages should not include private root `.agent/` working memory.
- Generated target projects should commit their `.agent/` memory by default, including `.agent/sessions/`.
- Do not commit real secret values.
- Reference secrets by name only, such as `DATABASE_URL` or `OPENAI_API_KEY`.
- Store real values in environment variables, a password manager, or `.agent/secrets.local.md`.
- Keep `.agent/secrets.local.md` ignored by git through `.agent/.gitignore`.

---

## Useful Commands

```bash
bash -n scripts/init-new-project.sh
bash -n scripts/copy-agent-system.sh
bash -n scripts/build-guide-pdf.sh
bash tests/test-scripts.sh
bash scripts/init-new-project.sh my-project-name
bash scripts/copy-agent-system.sh /path/to/existing-project
```

---

## Release Rule

Regenerate `_GUIDE/Alubys_AI_Dev_System_Guide.pdf` only after `_GUIDE/Alubys_AI_Dev_System_Guide.md` and the public release contents are final. Run: `bash scripts/build-guide-pdf.sh`
