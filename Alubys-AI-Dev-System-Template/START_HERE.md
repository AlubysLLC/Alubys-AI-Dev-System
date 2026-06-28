# START HERE
## Alubys AI Development System — No-Script Setup

You're holding a **ready-to-use project template**. There are no scripts to run — this folder works in locked-down corporate environments (Mac or Windows) where bash and PowerShell are blocked.

Setting up takes about two minutes: copy this folder, rename it, and fill in three placeholders.

---

## Step 1 — Copy and rename this folder

1. Copy this entire folder to wherever you keep your projects.
2. Rename the copy to your project's name (for example, `acme-billing-portal`).

> **Important — hidden files:** this template includes a hidden `.agent/` folder (it holds the AI's memory) and `.gitignore` files. If you copied a raw folder rather than extracting the ZIP, make sure hidden files came along:
> - **Mac:** in Finder, press `Cmd + Shift + .` to show hidden files and confirm `.agent/` is present.
> - **Windows:** in File Explorer, View → Show → Hidden items, and confirm `.agent\` is present.
>
> Extracting the distributed **ZIP** always preserves these files — prefer the ZIP if you can.

---

## Step 2 — Fill in the placeholders

The template ships with three placeholders that appear across several files. Replace every occurrence:

| Placeholder | Replace with | Example |
|-------------|--------------|---------|
| `[PROJECT NAME]` | Your project's human-readable name | `Acme Billing Portal` |
| `[project-name]` | A lowercase, hyphenated slug | `acme-billing-portal` |
| `[DATE]` | Today's date (`YYYY-MM-DD`) | `2026-06-28` |

Pick whichever path fits your environment:

### Easy path — let your AI do it
Open this folder with your file-aware AI assistant (Claude Code, Cursor, Codex, etc.) and say:

> *"Follow START_HERE.md to set this project up: replace `[PROJECT NAME]`, `[project-name]`, and `[DATE]` across all files with the correct values, then confirm what you changed."*

The AI handles the find-and-replace for you. No scripts required — the AI is already permitted in these environments.

### Manual path — find-and-replace in your editor
Use your editor's "Replace in Files" (VS Code, Sublime, Notepad++, etc.):
1. Replace `[PROJECT NAME]` → your project name
2. Replace `[project-name]` → your slug
3. Replace `[DATE]` → today's date

---

## Step 3 — Start working

1. Open the project with your AI assistant.
2. Ask it to **follow `AGENTS.md`** and run the startup protocol.
3. For a brand-new project, point it at `_PROMPTS/START_NEW_PROJECT_PROMPT.md`.
4. Choose an approval mode (Plan-First / Standard / Autonomous) and begin in Brainstorming mode.

> **Chat-only AI (no file access)?** Paste `_PROMPTS/MASTER_SYSTEM_PROMPT.md` and `_PROMPTS/START_NEW_PROJECT_PROMPT.md` into the chat manually.

---

## Adding this to an existing project instead

If you already have a project and just want to add the system to it:

1. Copy the **`.agent/`** folder, the **`_PROMPTS/`** folder, **`AGENTS.md`**, and **`CLAUDE.md`** into your existing project's root.
2. **Do not** copy this template's `README.md` over your own — keep yours.
3. Fill in the placeholders (Step 2) in the files you copied.
4. Open the project with your AI and ask it to follow `AGENTS.md`.

---

*Once setup is done, you can delete this START_HERE.md file. Your project is ready.*

*Alubys AI Development System — No-Script Template Setup v1.0*
