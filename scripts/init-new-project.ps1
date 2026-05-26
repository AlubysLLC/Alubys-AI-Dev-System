# =============================================================
# init-new-project.ps1
# Alubys AI Development System — Windows installer
#
# Usage (from PowerShell):
#   .\scripts\init-new-project.ps1 my-project-name
#   .\scripts\init-new-project.ps1 my-project-name C:\path\to\target
#
# Creates a new project directory, renders the template files,
# and copies the workflow prompts into the project.
#
# First-time setup: if PowerShell blocks the script, run once:
#   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# =============================================================

# ── Config ────────────────────────────────────────────────────────────────────
$ScriptDir    = $PSScriptRoot
$SystemRoot   = Split-Path -Parent $ScriptDir
$TemplatesDir = Join-Path $SystemRoot "templates"
$Today        = Get-Date -Format 'yyyy-MM-dd'

# ── Arguments ─────────────────────────────────────────────────────────────────
$ProjectName = if ($args[0]) { $args[0] } else { "my-project" }

if ($args[1]) {
    $TargetDir = $args[1]
} elseif ((Split-Path -Leaf (Get-Location)) -eq $ProjectName) {
    $TargetDir = (Get-Location).Path
} else {
    $TargetDir = Join-Path (Get-Location) $ProjectName
}

# ── Helpers ───────────────────────────────────────────────────────────────────
function Print-Step { param($msg) Write-Host ""; Write-Host "▶ $msg" }
function Print-Ok   { param($msg) Write-Host "  OK  $msg" }
function Print-Info { param($msg) Write-Host "  i   $msg" }
function Print-Warn { param($msg) Write-Host "  !   $msg" }

function Render-Template {
    param($Template, $Destination)
    $content = Get-Content -Path $Template -Raw -Encoding UTF8
    $content = $content -replace '\[PROJECT NAME\]', $ProjectName
    $content = $content -replace '\[project-name\]',  $ProjectName
    $content = $content -replace '\[DATE\]',           $Today
    $dir = Split-Path -Parent $Destination
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    [System.IO.File]::WriteAllText($Destination, $content, [System.Text.UTF8Encoding]::new($false))
}

function Render-TemplateIfMissing {
    param($Template, $Destination)
    if (Test-Path $Destination) {
        Print-Info "Kept existing: $(Split-Path -Leaf $Destination)"
    } else {
        Render-Template $Template $Destination
        Print-Ok (Split-Path -Leaf $Destination)
    }
}

function Render-AgentTemplates {
    $agentDir = Join-Path $TemplatesDir ".agent"
    $templates = Get-ChildItem -Path $agentDir -Recurse -File -Filter "*.template" |
                 Sort-Object FullName
    foreach ($t in $templates) {
        $relative = $t.FullName.Substring($TemplatesDir.Length + 1)
        $relative = $relative -replace '\.template$', ''
        $destination = Join-Path $TargetDir $relative
        Render-Template $t.FullName $destination
        $short = $destination.Substring($TargetDir.Length + 1)
        Print-Ok $short
    }
}

function Copy-PromptFiles {
    $promptsDir = Join-Path $TargetDir "_PROMPTS"
    if (-not (Test-Path $promptsDir)) {
        New-Item -ItemType Directory -Force -Path $promptsDir | Out-Null
    }
    $prompts = @(
        "MASTER_SYSTEM_PROMPT.md",
        "START_NEW_PROJECT_PROMPT.md",
        "ONBOARD_EXISTING_PROJECT_PROMPT.md",
        "BRAINSTORMING_MODE_PROMPT.md",
        "PLANNING_MODE_PROMPT.md",
        "EXECUTION_MODE_PROMPT.md",
        "REFLECTION_MODE_PROMPT.md"
    )
    foreach ($prompt in $prompts) {
        $src = Join-Path $SystemRoot "_PROMPTS" $prompt
        $dst = Join-Path $promptsDir $prompt
        if (Test-Path $src) {
            Copy-Item -Path $src -Destination $dst -Force
            Print-Ok "_PROMPTS\$prompt"
        } else {
            Print-Warn "Missing prompt: _PROMPTS\$prompt"
        }
    }
}

# ── Main ──────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "╔══════════════════════════════════════════════════╗"
Write-Host "║   Alubys AI Development System                   ║"
Write-Host "║   Initializing new project: $ProjectName"
Write-Host "╚══════════════════════════════════════════════════╝"

# ── Terms of Use acceptance ───────────────────────────────────────────────────
Write-Host ""
Write-Host "  TERMS OF USE -- Alubys, LLC"
Write-Host "  --------------------------------------------------"
Write-Host "  This software is provided without warranty of any kind."
Write-Host "  By proceeding, you accept full responsibility for all"
Write-Host "  outcomes, including data loss and AI token costs."
Write-Host "  Alubys, LLC is held harmless from any claims."
Write-Host ""
Write-Host "  Full Terms of Use: https://alubysllc.github.io/terms"
Write-Host ""
$termsAccept = Read-Host "  Type YES to accept the Terms of Use and continue"
if ($termsAccept -ne "YES") {
    Write-Host "  Terms not accepted. Exiting."
    exit 0
}
Write-Host ""

if (-not (Test-Path $TemplatesDir)) {
    Write-Host "ERROR: Templates directory not found: $TemplatesDir"
    exit 1
}

Print-Step "Creating project directory"
New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
Print-Ok "Created: $TargetDir"

Print-Step "Rendering .agent/ templates"
Render-AgentTemplates

Print-Step "Rendering root templates"
Render-Template (Join-Path $TemplatesDir "AGENTS.md.template") (Join-Path $TargetDir "AGENTS.md")
Print-Ok "AGENTS.md"
Render-Template (Join-Path $TemplatesDir "CLAUDE.md.template") (Join-Path $TargetDir "CLAUDE.md")
Print-Ok "CLAUDE.md"
Render-TemplateIfMissing (Join-Path $TemplatesDir "README.md.template") (Join-Path $TargetDir "README.md")

Print-Step "Copying workflow prompt files"
Copy-PromptFiles

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════╗"
Write-Host "║   Project initialized successfully!              ║"
Write-Host "╚══════════════════════════════════════════════════╝"
Write-Host ""
Print-Info "Project location: $TargetDir"
Print-Info ""
Print-Info "Next steps:"
Print-Info "  1. cd $TargetDir"
Print-Info "  2. Open your AI assistant"
Print-Info "  3. Ask your file-aware AI agent to follow AGENTS.md"
Print-Info "     and use _PROMPTS\START_NEW_PROJECT_PROMPT.md"
Print-Info "  4. Choose approval mode and begin brainstorming"
Print-Info "  Fallback: for chat-only tools, paste MASTER_SYSTEM_PROMPT.md"
Print-Info "  and START_NEW_PROJECT_PROMPT.md manually."
Write-Host ""
