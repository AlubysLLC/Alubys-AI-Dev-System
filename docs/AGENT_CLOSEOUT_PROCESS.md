# Agent Closeout Process
## Alubys AI Development System

> The session closeout is not optional. It is what makes continuity possible.
> Every session that ends without a proper closeout puts the project at risk.

---

## Why Closeout Matters

When a session ends without closeout:
- The next session starts cold
- Work done gets rediscovered instead of built upon
- Decisions get re-debated
- Mistakes get repeated
- Momentum is lost

When closeout is done well:
- The next AI picks up in 2 minutes
- Every session compounds on the previous one
- The project grows smarter over time

---

## The Closeout Checklist

Run this at the end of every session, regardless of how much or little was done.

### Step 1: Summarize completed work
List 2–5 bullet points of what was actually completed this session. Be specific about deliverables, not vague about effort.

```
✅ Built authentication endpoint (POST /api/auth/login)
✅ Added input validation with Zod schema
✅ Wrote 3 unit tests for auth service
🔄 Started refresh token logic (incomplete — see in-progress.md)
```

### Step 2: Update active-context.md
This is the most critical update. Reflect:
- Current mode and phase
- What was just completed
- What's immediately next
- Any new blockers or open questions

The test: someone reading this file cold should know exactly where the project is.

### Step 3: Update changelog.md
Append one entry for this session:
```markdown
## [DATE] — [Session Title]
### Completed
- ✅ [Item]
### Decisions Made
- 📝 [Decision]
### Notes
[Relevant context]
```

### Step 4: Update in-progress.md
- Mark completed tasks as done (move to Step 5)
- Update status of any still-active tasks
- Add any new tasks that emerged during the session

### Step 5: Move completed tasks to completed.md
For every task that's fully done, move it from `in-progress.md` to `completed.md` with the date.

### Step 6: Add to lessons-learned.md
Did anything happen this session that's worth remembering for future sessions?
- A bug you figured out
- A pattern that worked well
- A shortcut that backfired
- A tool behavior worth knowing

If yes, add a new entry. If nothing new — that's fine, skip this step.

### Step 7: List next session's recommended steps
Add 2–4 specific next steps to `active-context.md`:
```
## Immediate Next Step
Build refresh token endpoint — schema is defined, just needs implementation.

## Upcoming (Next 2–3 Sessions)
- [ ] Refresh token endpoint
- [ ] Password reset flow
- [ ] Email verification
```

---

## Abbreviated Closeout (for short sessions)

For sessions under 30 minutes or sessions where nothing was completed:

1. Update `active-context.md` — current state (even if unchanged)
2. Append a brief `changelog.md` entry
3. Note next session's focus

Even a 5-minute closeout is worth doing.

---

## Closing Statement

When closeout is complete, the AI should say:

```
Session closeout complete — [DATE]

Completed: [N] tasks
Updated: active-context.md, changelog.md, in-progress.md
Lessons recorded: [N]

Next session should start with: [Single most important next step]
```

---

*Alubys AI Development System — Agent Closeout Process v1.0*
