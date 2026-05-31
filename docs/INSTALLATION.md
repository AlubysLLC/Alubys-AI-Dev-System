# Installation
## Alubys AI Development System

Install the system once per machine. You reference it from all your projects — you do not copy or reinstall it for each project.

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
