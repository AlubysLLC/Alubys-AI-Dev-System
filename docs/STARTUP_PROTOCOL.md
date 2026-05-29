# Startup Protocol

Every AI session begins the same way, whether it is the first session or the fiftieth. This takes 30 seconds.

---

## Steps

### 1. Open a new session with your AI assistant
Start a fresh chat or open your project in a file-aware AI tool.

### 2. Load the system prompt

**File-aware agents** (Claude Code, Cursor, Codex):
The AI reads `AGENTS.md` and `_PROMPTS/MASTER_SYSTEM_PROMPT.md` automatically. No pasting needed.

**Chat-only tools** (Claude.ai, ChatGPT, Gemini):
Open `_PROMPTS/MASTER_SYSTEM_PROMPT.md` in a text editor → Select All → Copy → Paste into the AI chat.

> **Tip:** Select All (Cmd+A on Mac, Ctrl+A on Windows) → Copy (Cmd+C / Ctrl+C) → Paste (Cmd+V / Ctrl+V). Always paste raw text — do not attach the file.

### 3. Say: "Read the startup files and tell me where we are."
The AI reads 5 key files from `.agent/` and returns a brief status summary.

### 4. Confirm or correct the summary
If the summary is accurate, proceed. If anything is wrong, correct it before any work begins.

### 5. Work begins
The AI is now fully oriented with current project state.

---

## Files the AI Reads at Startup

| File | Purpose |
|------|---------|
| `.agent/memory/active-context.md` | Current project state — the most important file |
| `.agent/tasks/in-progress.md` | What is actively being worked on right now |
| `.agent/tasks/roadmap.md` | Where the project is going |
| `.agent/memory/lessons-learned.md` | Rules and patterns to honor this session |
| `.agent/memory/decisions.md` | Architecture decisions already made |

---

## Common Startup Mistakes

| Mistake | Why It Hurts |
|---------|-------------|
| Skipping startup entirely | AI starts cold and gives irrelevant suggestions |
| Attaching `.md` files instead of pasting | Some AI interfaces don't read attachments the same way |
| Starting work before the AI confirms orientation | Decisions get made without full context |

---

*After the session: [Closeout Protocol](docs/AGENT_CLOSEOUT_PROCESS.md) — [Checkpoint Protocol](docs/CHECKPOINT_PROTOCOL.md)*
