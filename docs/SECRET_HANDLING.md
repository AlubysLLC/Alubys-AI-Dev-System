# Secret Handling

Tracked files may reference secret names, but must never contain real secret values.

---

## The Rule

| Allowed in tracked files | Never in tracked files |
|--------------------------|----------------------|
| `Uses OPENAI_API_KEY from the deployment environment` | The actual API key |
| `DATABASE_URL is configured in the hosting provider` | The actual database URL |
| `Local-only setup notes are in .agent/secrets.local.md` | Passwords or tokens |

---

## Where Real Values Belong

- Environment variables on your machine or server
- A password manager (1Password, Bitwarden, etc.)
- Your hosting provider's secret storage (Heroku Config Vars, AWS Secrets Manager, etc.)
- `.agent/secrets.local.md` — local only, git-ignored

---

## The `.agent/secrets.local.md` File

This file is for local-only notes about secrets — never committed to version control.

It is git-ignored by `.agent/.gitignore` automatically when you run the installer scripts.

Use `.agent/secrets.example.md` (committed) to document what secrets exist and where they live — with placeholder names only.

**Example `secrets.example.md`:**
```markdown
# Secrets Reference

## Required Environment Variables
- OPENAI_API_KEY — your OpenAI API key, set in .env or system environment
- DATABASE_URL — PostgreSQL connection string, from hosting provider dashboard
- STRIPE_SECRET_KEY — from Stripe dashboard (test vs. live)

## Where to Find Real Values
- API keys: password manager → "Project Name" folder
- Database: hosting provider → Settings → Database
```

---

## If You Find Secrets in Tracked Files

Flag them immediately. Do not copy them, reference them in changelogs, or paste them into AI chats. Rotate any exposed secrets before doing anything else.
