# Templates & Scripts

The installer scripts generate all project files from the `templates/` directory. You do not need to modify templates to use the system.

---

## The Scripts

### New Project

**Mac / Linux:**
```bash
bash ~/Tools/Alubys-AI-Dev-System/scripts/init-new-project.sh my-project-name
cd my-project-name
```

**Windows (PowerShell):**
```powershell
.\scripts\init-new-project.ps1 my-project-name
cd my-project-name
```

Creates the project folder with `AGENTS.md`, `CLAUDE.md`, all mode prompt files, and the full `.agent/` memory structure.

---

### Existing Project

**Mac / Linux:**
```bash
cd ~/Projects/my-existing-project
bash ~/Tools/Alubys-AI-Dev-System/scripts/copy-agent-system.sh
```

**Windows (PowerShell):**
```powershell
cd C:\Projects\my-existing-project
.\scripts\copy-agent-system.ps1
```

Adds only new files — never overwrites or modifies anything you already have.

> **Back up first.** Before running any script on an existing project, commit all changes to git or duplicate the project folder.

---

### Windows First-Time Setup

If PowerShell blocks the script, run this once:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

### Verify Scripts (Mac / Linux)

```bash
bash tests/test-scripts.sh
```

Run this after any change to installer scripts or templates.

---

## The Templates Directory

```text
templates/
├── AGENTS.md.template
├── CLAUDE.md.template
├── README.md.template
├── README.ToBeMerged.md.template
└── .agent/
    ├── .gitignore.template
    ├── secrets.example.md.template
    ├── memory/
    ├── planning/
    ├── tasks/
    ├── sessions/
    └── reflections/
```

If you want to customize the files installed into your projects — for example to pre-fill your organization name, standard tools, or default approval mode — edit the corresponding files in `templates/` before running the installer scripts.

---

## How the Scripts Work

The installer scripts are intentionally thin: they render templates and copy prompt files. Content belongs in templates, not inline in scripts. This keeps templates as the single source of truth for generated output and prevents script/template drift.
