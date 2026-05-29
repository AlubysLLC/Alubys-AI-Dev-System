# Quick Reference Card

---

## Session Startup — 30 seconds

```
1. Open a new session with your AI assistant
2. For chat-only tools: paste _PROMPTS/MASTER_SYSTEM_PROMPT.md
3. Say: "Read the startup files and tell me where we are."
4. AI reads 5 files, gives status summary, work begins
```

---

## Session Closeout — 2 minutes

```
Say: "Run the closeout protocol."
AI runs 7 steps, then runs the mandatory Memory Test.
Session only closes when Memory Test passes.
```

---

## Mid-Session Checkpoint — 30 seconds

```
Say: "Run checkpoint."
AI saves active-context.md, in-progress.md, and changelog.md.
Work continues — session does not end.
Use on long sessions or before risky changes.
```

---

## Which Prompt File to Use

| Situation | Use This File |
|-----------|--------------|
| Any session start | `_PROMPTS/MASTER_SYSTEM_PROMPT.md` |
| First session, new project | `_PROMPTS/START_NEW_PROJECT_PROMPT.md` |
| First session, existing project | `_PROMPTS/ONBOARD_EXISTING_PROJECT_PROMPT.md` |
| Exploring a problem | `_PROMPTS/BRAINSTORMING_MODE_PROMPT.md` |
| Designing architecture | `_PROMPTS/PLANNING_MODE_PROMPT.md` |
| Building features | `_PROMPTS/EXECUTION_MODE_PROMPT.md` |
| Weekly review / phase end | `_PROMPTS/REFLECTION_MODE_PROMPT.md` |

---

## How to "Paste a File"

Open the `.md` file from `_PROMPTS/` in any text editor → Select All (Cmd+A on Mac, Ctrl+A on Windows) → Copy → Paste into AI chat. Always paste raw text — do not attach as a file.

---

## Common Mistakes to Avoid

| Mistake | Why It Hurts |
|---------|-------------|
| Skipping startup protocol | AI starts cold and gives irrelevant suggestions |
| Skipping closeout protocol | Session work evaporates — next session rediscovers it |
| Skipping Checkpoint on long sessions | Context compacting mid-session can lose in-progress reasoning |
| Attaching `.md` files instead of pasting | Some AI interfaces don't read attachments the same way |
| Cloning the repo into every project | Clone once to `~/Tools` — use the scripts |
| Not backing up before onboarding | Copy script is safe, but always back up live projects first |
| Jumping from idea to code | Use Brainstorming and Planning modes first |
| Storing secrets in files | Never — use environment variables only |
| Skipping Reflection Mode | Technical debt accumulates silently — run it at least weekly |

---

## Installer Commands

**Mac / Linux**
```bash
# New project
bash ~/Tools/Alubys-AI-Dev-System/scripts/init-new-project.sh my-project-name

# Existing project
bash ~/Tools/Alubys-AI-Dev-System/scripts/copy-agent-system.sh
```

**Windows (PowerShell)**
```powershell
# New project
.\scripts\init-new-project.ps1 my-project-name

# Existing project
.\scripts\copy-agent-system.ps1
```
