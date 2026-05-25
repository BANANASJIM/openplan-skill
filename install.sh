#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$ROOT_DIR/skills"

CODEX_DIR="${CODEX_SKILLS_DIR:-${CODEX_HOME:-$HOME/.codex}/skills}"
CLAUDE_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
ONLY="both"
COMMANDS_DIR=""
DRY_RUN=0
FORCE=0
MARKER_FILE=".openplan-skill-installed"
RUN_ID="$(date -u +%Y%m%dT%H%M%SZ)"
LEGACY_SKILLS=("openplan-yolo" "openplan-doc-init")

usage() {
  cat <<'EOF'
Usage: ./install.sh [options]

Install OpenPlan Agent Skills for Codex and Claude Code.

Options:
  --only codex|claude|both     Install target set. Default: both.
  --codex-dir PATH             Codex skills directory. Default: ${CODEX_HOME:-$HOME/.codex}/skills.
  --claude-dir PATH            Claude skills directory. Default: ~/.claude/skills.
  --commands-dir PATH          Also generate legacy Claude slash-command prompts into PATH.
  --force                      Replace existing unmarked openplan-* skill directories.
  --dry-run                    Print actions without writing files.
  --list                       List bundled skills.
  -h, --help                   Show this help.

Examples:
  ./install.sh
  ./install.sh --force
  ./install.sh --only codex
  ./install.sh --only claude --claude-dir .claude/skills
  ./install.sh --commands-dir ~/.claude/commands
EOF
}

die() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

log() {
  printf '%s\n' "$*"
}

list_skills() {
  find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 -type d | while IFS= read -r dir; do
    basename "$dir"
  done | sort
}

validate_bundle() {
  "$ROOT_DIR/scripts/validate-skills" >/dev/null
}

can_replace() {
  local dst="$1"

  [[ ! -e "$dst" ]] && return 0
  [[ "$FORCE" -eq 1 ]] && return 0
  [[ -f "$dst/$MARKER_FILE" ]] && return 0

  return 1
}

backup_path() {
  local path="$1"
  local backup="$path.backup.$RUN_ID"
  local n=1

  while [[ -e "$backup" ]]; do
    backup="$path.backup.$RUN_ID.$n"
    n=$((n + 1))
  done

  printf '%s\n' "$backup"
}

warn_legacy_skills() {
  local dst_parent="$1"
  local legacy
  local dst

  for legacy in "${LEGACY_SKILLS[@]}"; do
    dst="$dst_parent/$legacy"
    if [[ -e "$dst" ]]; then
      log "warning: legacy skill remains installed at $dst; review and remove manually if no longer needed"
    fi
  done
}

copy_skill() {
  local src="$1"
  local dst_parent="$2"
  local name
  local dst
  local tmp
  local backup

  name="$(basename "$src")"
  dst="$dst_parent/$name"
  tmp=""

  if [[ "$DRY_RUN" -eq 1 ]]; then
    if can_replace "$dst"; then
      if [[ -e "$dst" ]]; then
        log "would back up $dst before replacement"
      fi
      log "would install $name -> $dst"
    else
      log "would refuse existing unmarked skill $dst (use --force)"
    fi
    return
  fi

  mkdir -p "$dst_parent"
  if ! can_replace "$dst"; then
    die "refusing to overwrite existing unmarked skill: $dst (use --force if this is intentional)"
  fi
  tmp="$(mktemp -d "$dst_parent/.${name}.tmp.XXXXXX")"
  cp -a "$src/." "$tmp/" || {
    rm -rf "$tmp"
    die "failed to copy $name into temporary directory"
  }
  {
    printf 'source=%s\n' "$ROOT_DIR"
    printf 'installed_at=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  } > "$tmp/$MARKER_FILE" || {
    rm -rf "$tmp"
    die "failed to write install marker for $name"
  }
  if [[ -e "$dst" ]]; then
    backup="$(backup_path "$dst")"
    mv "$dst" "$backup"
    log "backed up $dst -> $backup"
  fi
  mv "$tmp" "$dst"
  log "installed $name -> $dst"
}

install_to() {
  local dst_parent="$1"
  local skill

  [[ -d "$SOURCE_DIR" ]] || die "missing skills directory: $SOURCE_DIR"
  warn_legacy_skills "$dst_parent"
  while IFS= read -r skill; do
    copy_skill "$SOURCE_DIR/$skill" "$dst_parent"
  done < <(list_skills)
}

install_commands() {
  local skill
  local src
  local dst
  local backup

  [[ -n "$COMMANDS_DIR" ]] || return 0

  while IFS= read -r skill; do
    src="$SOURCE_DIR/$skill/assets/claude-code-command.md"
    dst="$COMMANDS_DIR/$skill.md"
    [[ -f "$src" ]] || continue

    if [[ "$DRY_RUN" -eq 1 ]]; then
      if [[ -e "$dst" && "$FORCE" -ne 1 ]]; then
        log "would refuse existing command $dst (use --force)"
      else
        if [[ -e "$dst" ]]; then
          log "would back up $dst before replacement"
        fi
        log "would install command $skill -> $dst"
      fi
      continue
    fi

    mkdir -p "$COMMANDS_DIR"
    if [[ -e "$dst" && "$FORCE" -ne 1 ]]; then
      die "refusing to overwrite existing command: $dst (use --force if this is intentional)"
    fi
    if [[ -e "$dst" ]]; then
      backup="$(backup_path "$dst")"
      mv "$dst" "$backup"
      log "backed up $dst -> $backup"
    fi
    cp "$src" "$dst"
    log "installed command $skill -> $dst"
  done < <(list_skills)
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --only)
      [[ $# -ge 2 ]] || die "--only requires codex, claude, or both"
      ONLY="$2"
      shift 2
      ;;
    --codex-dir)
      [[ $# -ge 2 ]] || die "--codex-dir requires a path"
      CODEX_DIR="$2"
      shift 2
      ;;
    --claude-dir)
      [[ $# -ge 2 ]] || die "--claude-dir requires a path"
      CLAUDE_DIR="$2"
      shift 2
      ;;
    --commands-dir)
      [[ $# -ge 2 ]] || die "--commands-dir requires a path"
      COMMANDS_DIR="$2"
      shift 2
      ;;
    --force)
      FORCE=1
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --list)
      list_skills
      exit 0
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "unknown option: $1"
      ;;
  esac
done

validate_bundle

case "$ONLY" in
  codex)
    install_to "$CODEX_DIR"
    ;;
  claude)
    install_to "$CLAUDE_DIR"
    ;;
  both)
    install_to "$CODEX_DIR"
    install_to "$CLAUDE_DIR"
    ;;
  *)
    die "--only must be codex, claude, or both"
    ;;
esac

install_commands

log "done"
