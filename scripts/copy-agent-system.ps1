# =============================================================
# copy-agent-system.ps1
# Alubys AI Development System — Windows installer
#
# Usage (from PowerShell):
#   .\scripts\copy-agent-system.ps1
#   .\scripts\copy-agent-system.ps1 C:\path\to\existing-project
#
# Adds the Alubys templates and prompt files to an existing
# project without overwriting existing files.
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
$TargetDir   = if ($args[0]) { $args[0] } else { (Get-Location).Path }
$ProjectName = Split-Path -Leaf $TargetDir

# ── Helpers ───────────────────────────────────────────────────────────────────
function Print-Step { param($msg) Write-Host ""; Write-Host "▶ $msg" }
function Print-Ok   { param($msg) Write-Host "  OK   $msg" }
function Print-Skip { param($msg) Write-Host "  --   Skipped (already exists): $msg" }
function Print-Warn { param($msg) Write-Host "  !    $msg" }

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
        Print-Skip (Split-Path -Leaf $Destination)
    } else {
        Render-Template $Template $Destination
        Print-Ok (Split-Path -Leaf $Destination)
    }
}

function Render-AgentTemplatesIfMissing {
    $agentDir = Join-Path $TemplatesDir ".agent"
    $templates = Get-ChildItem -Path $agentDir -Recurse -File -Filter "*.template" |
                 Sort-Object FullName
    foreach ($t in $templates) {
        $relative = $t.FullName.Substring($TemplatesDir.Length + 1)
        $relative = $relative -replace '\.template$', ''
        $destination = Join-Path $TargetDir $relative
        Render-TemplateIfMissing $t.FullName $destination
    }
}

function Copy-PromptIfMissing {
    param($Prompt)
    $promptsDir = Join-Path $TargetDir "_PROMPTS"
    if (-not (Test-Path $promptsDir)) {
        New-Item -ItemType Directory -Force -Path $promptsDir | Out-Null
    }
    $dst = Join-Path $promptsDir $Prompt
    $src = Join-Path $SystemRoot "_PROMPTS" $Prompt
    if (Test-Path $dst) {
        Print-Skip "_PROMPTS\$Prompt"
    } elseif (Test-Path $src) {
        Copy-Item -Path $src -Destination $dst
        Print-Ok "_PROMPTS\$Prompt"
    } else {
        Print-Warn "Missing prompt: _PROMPTS\$Prompt"
    }
}

# ── Header ────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "╔══════════════════════════════════════════════════╗"
Write-Host "║   Alubys AI Development System                   ║"
Write-Host "║   Onboarding existing project                    ║"
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
Write-Host "  Target project: $TargetDir"
Write-Host "  Project name:   $ProjectName"
Write-Host ""
$confirm = Read-Host "  Proceed? This will ADD files only (never overwrite). [y/N]"
if ($confirm -notmatch '^[Yy]$') {
    Write-Host "  Cancelled."
    exit 0
}

if (-not (Test-Path $TemplatesDir)) {
    Write-Host "ERROR: Templates directory not found: $TemplatesDir"
    exit 1
}

# ── Render templates ──────────────────────────────────────────────────────────
Print-Step "Rendering .agent/ templates (skip if exist)"
Render-AgentTemplatesIfMissing

Print-Step "Rendering root templates (skip if exist)"
Render-TemplateIfMissing (Join-Path $TemplatesDir "AGENTS.md.template") (Join-Path $TargetDir "AGENTS.md")
Render-TemplateIfMissing (Join-Path $TemplatesDir "CLAUDE.md.template") (Join-Path $TargetDir "CLAUDE.md")

$readmePath = Join-Path $TargetDir "README.md"
if (Test-Path $readmePath) {
    Render-TemplateIfMissing (Join-Path $TemplatesDir "README.ToBeMerged.md.template") `
                             (Join-Path $TargetDir "README.ToBeMerged.md")
} else {
    Render-TemplateIfMissing (Join-Path $TemplatesDir "README.md.template") $readmePath
}

# ── Copy workflow prompts ─────────────────────────────────────────────────────
Print-Step "Copying workflow prompt files (skip if exist)"
foreach ($prompt in @(
    "MASTER_SYSTEM_PROMPT.md",
    "ONBOARD_EXISTING_PROJECT_PROMPT.md",
    "BRAINSTORMING_MODE_PROMPT.md",
    "PLANNING_MODE_PROMPT.md",
    "EXECUTION_MODE_PROMPT.md",
    "REFLECTION_MODE_PROMPT.md"
)) {
    Copy-PromptIfMissing $prompt
}

# ── Git tracking note ─────────────────────────────────────────────────────────
Print-Step "Git tracking note"
Print-Warn "Commit .agent/ memory, planning, tasks, reflections, and sessions unless your project policy says otherwise."
Print-Warn "Do not commit real secrets. Use environment variables, a password manager, or .agent\secrets.local.md."

# ── Done ──────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "╔══════════════════════════════════════════════════╗"
Write-Host "║   Alubys system added to existing project!       ║"
Write-Host "╚══════════════════════════════════════════════════╝"
Write-Host ""
Write-Host "  Next steps:"
Write-Host "  1. Open your AI assistant"
Write-Host "  2. Ask your file-aware AI agent to follow AGENTS.md"
Write-Host "     and use _PROMPTS\ONBOARD_EXISTING_PROJECT_PROMPT.md"
Write-Host "  3. Choose approval mode and let the AI inspect and document the project"
Write-Host "  Fallback: for chat-only tools, paste MASTER_SYSTEM_PROMPT.md"
Write-Host "  and ONBOARD_EXISTING_PROJECT_PROMPT.md manually."
Write-Host ""
