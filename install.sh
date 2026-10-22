#!/usr/bin/env bash
# agent-stack installer — installs curated agent skills via `npx skills`
# Usage:
#   ./install.sh                    # install everything (full manifest)
#   ./install.sh frontend backend   # install specific presets (from presets/presets.json)
#   DRY_RUN=1 ./install.sh          # preview commands only
set -euo pipefail
cd "$(dirname "$0")"

MANIFEST="skills.json"
PRESETS_FILE="presets/presets.json"
DRY_RUN="${DRY_RUN:-0}"

command -v npx >/dev/null || { echo "error: npx not found (install Node.js)"; exit 1; }
command -v python3 >/dev/null || { echo "error: python3 not found"; exit 1; }

run_add() {
  # $@ = full npx skills add command args
  if [[ "$DRY_RUN" == "1" ]]; then
    echo "  [dry-run] $*"
  else
    if npx -y "$@" >/dev/null 2>&1; then
      echo "  ✓ ${!#}"
    else
      echo "  ✗ ${!#} (failed — skipped)"
    fi
  fi
}

echo "==> agent-stack: installing curated agent skills"

if [[ $# -gt 0 ]]; then
  for preset in "$@"; do
    echo "--- preset: $preset ---"
    SKILLS=$(python3 -c "
import json
p = json.load(open('$PRESETS_FILE'))
if '$preset' not in p: raise SystemExit(f'preset not found: $preset')
print('\n'.join(p['$preset']['skills']))
") || exit 1
    while IFS= read -r entry; do
      [[ -z "$entry" ]] && continue
      if [[ "$entry" == https://* ]]; then
        run_add skills add "$entry" -g -y
      else
        run_add skills add "$entry" -g -y
      fi
    done <<< "$SKILLS"
  done
else
  echo "--- full manifest ---"
  DRY_RUN="$DRY_RUN" python3 - "$MANIFEST" <<'PY'
import json, subprocess, sys, os
m = json.load(open(sys.argv[1]))
dry = os.environ.get("DRY_RUN") == "1"
for source, meta in m["skills"].items():
    src = meta.get("source", source)
    for skill in meta["skills"]:
        if src.startswith("https://"):
            cmd = ["skills", "add", src, "-g", "-y"]
        else:
            cmd = ["skills", "add", f"{src}@{skill}", "-g", "-y"]
        if dry:
            print(f"  [dry-run] npx -y {' '.join(cmd)}")
        else:
            r = subprocess.run(["npx", "-y"] + cmd, capture_output=True)
            print(f"  ✓ {skill}" if r.returncode == 0 else f"  ✗ {skill} (skipped)")
PY
fi

echo
echo "==> MCP servers: portable config is in mcp.json"
echo "    Add the mcpServers block to your agent's config:"
echo "      • Hermes:      hermes mcp add <name> (--url ... | --command npx --args ...)"
echo "      • Claude Code: claude mcp add-json <name> '<json>'"
echo "      • Cursor/VS Code: paste mcp.json into MCP settings"
echo
echo "Done. Skills install globally (~/.agents/skills) and symlink into detected agents."
