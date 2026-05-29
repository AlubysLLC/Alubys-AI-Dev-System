# Approval Modes

Approval modes let each project decide how much autonomy the AI should have. Choose one at the start of a new or onboarded project and record it in `AGENTS.md` and `active-context.md`.

---

## The Three Modes

### Plan-First Mode

The AI presents a complete plan and waits for explicit approval before:
- Changing files
- Moving or deleting files
- Running commands or scripts
- Installing dependencies
- Making any implementation changes

**Use when:** You want maximum control and review before any action. Good for critical projects, unfamiliar codebases, or when working with a new AI assistant.

---

### Standard Mode

The AI proceeds with safe, scoped work after orientation. It asks before:
- Destructive or irreversible actions
- Broad or cross-cutting changes
- External-impact actions (push, deploy, publish)

**Use when:** You trust the AI to handle routine work but want guardrails on risky actions. The default for most projects.

---

### Autonomous Mode

The AI proceeds through implementation and verification within the requested scope. It still asks before:
- Destructive actions
- External-impact actions (push, deploy, publish)
- Handling credentials or secrets
- Broad architecture changes

**Use when:** You want higher throughput and trust the AI to work within a well-defined scope.

---

## Universal Rules — All Modes

Regardless of approval mode, the AI must always ask before:

- Deleting data or files
- Overwriting user work
- Changing git history
- Publishing, deploying, or pushing externally
- Handling real secrets or credentials
- Making broad architecture or product-direction changes

---

## How to Set the Approval Mode

Record it in two places so every session honors it immediately:

**In `AGENTS.md`:**
```markdown
## Approval Mode
Plan-First Mode
```

**In `.agent/memory/active-context.md`:**
```markdown
**Approval Mode:** Plan-First Mode
```

To change mode mid-project, update both files and tell the AI at the start of the next session.
