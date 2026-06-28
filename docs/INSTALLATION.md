# Installation
## Alubys AI Development System

Install the system once per machine. You reference it from all your projects — you do not copy or reinstall it for each project.

> **In a locked-down corporate environment where scripts are blocked?** Skip the clone-and-script setup below and use the [No-Script Install](#no-script-install-script-blocked-environments) — a ready-to-use template folder you copy and rename. No bash, no PowerShell.

---

## No-Script Install (Script-Blocked Environments)

Some corporate Macs and Windows machines block bash and PowerShell scripts. For those, the system ships as a **ready-to-use template folder** you copy and rename — no scripts required.

1. **Download the template ZIP:**
   [Alubys-AI-Dev-System-Template.zip](https://github.com/AlubysLLC/Alubys-AI-Dev-System/raw/main/Alubys-AI-Dev-System-Template.zip)
2. **Extract it.** Always extract the ZIP rather than copying a raw folder — the ZIP preserves the hidden `.agent/` memory folder, which a drag-copy can silently drop.
3. **Rename** the extracted folder to your project's name.
4. **Open `START_HERE.md`** inside the folder and follow it. Setup is one find-and-replace of three placeholders (`[PROJECT NAME]`, `[project-name]`, `[DATE]`) — your AI assistant can do it for you, or you can do it manually in your editor.

That's it — no install-once step, no scripts. Each project is a self-contained copy of the template.

---

## Step 1 — Clone the Repository

**Mac / Linux**
```bash
mkdir -p ~/Tools
cd ~/Tools
git clone https://github.com/AlubysLLC/Alubys-AI-Dev-System.git
```

**Windows (PowerShell)**
```powershell
mkdir C:\Tools
cd C:\Tools
git clone https://github.com/AlubysLLC/Alubys-AI-Dev-System.git
```

After cloning, the system lives at:
- Mac / Linux: `~/Tools/Alubys-AI-Dev-System/`
- Windows: `C:\Tools\Alubys-AI-Dev-System\`

You only do this once per machine. The installer scripts inside are called from any project directory whenever you need them.

---

## Windows First-Time Setup

If PowerShell blocks the script, run this once:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## Staying Up to Date

To get the latest version of the system:

**Mac / Linux**
```bash
cd ~/Tools/Alubys-AI-Dev-System
git pull
```

**Windows (PowerShell)**
```powershell
cd C:\Tools\Alubys-AI-Dev-System
git pull
```

---

## Next Steps

- [Quickstart](docs/QUICKSTART.md) — set up your first project in under 10 minutes
- [New Project](docs/NEW_PROJECT_WORKFLOW.md) — full step-by-step for starting a new project
- [Existing Project](docs/EXISTING_PROJECT_WORKFLOW.md) — add the system to a project you already have

---

*Alubys AI Development System — Installation v1.0*
