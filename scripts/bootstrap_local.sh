#!/usr/bin/env bash
# One-shot setup: ensure the shared rl-harness library sits beside this repo,
# then editable-install it into this experiment environment.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PARENT="$(dirname "$ROOT")"
LIB_LINK="$PARENT/rl-harness"
LIB_SPACED="$PARENT/RL Harness"
LIBRARY_URL="${RL_HARNESS_URL:-https://github.com/Al-does/RL-Harness.git}"

echo "==> experiment repo: $ROOT"
echo "==> library target:  $LIB_LINK"

if [ -d "$LIB_LINK/.git" ]; then
  echo "==> using existing library checkout at $LIB_LINK"
elif [ -L "$LIB_LINK" ] && [ -d "$LIB_LINK" ]; then
  echo "==> using existing library symlink at $LIB_LINK -> $(readlink "$LIB_LINK")"
elif [ -d "$LIB_SPACED/.git" ]; then
  echo "==> linking $LIB_LINK -> 'RL Harness'"
  ln -s "RL Harness" "$LIB_LINK"
else
  echo "==> cloning $LIBRARY_URL"
  echo "    into     $LIB_LINK"
  git clone "$LIBRARY_URL" "$LIB_LINK"
fi

if ! command -v uv >/dev/null 2>&1; then
  echo "ERROR: uv is required. Install from https://docs.astral.sh/uv/" >&2
  exit 1
fi

cd "$ROOT"
echo "==> uv sync --group dev (editable rl-harness from $LIB_LINK)"
uv sync --group dev

echo
echo "Ready."
echo
echo "  Stay current on the library:"
echo "    git -C \"$LIB_LINK\" pull"
echo
echo "  Run the example smoke experiment:"
echo "    uv run rl-harness experiments.example_study.smoke.experiment --smoke"
echo
echo "  Science commits: push to YOUR fork of rl-experiments (not a rename)."
echo "  Library PRs:     work in $LIB_LINK and open a PR to rl-harness."
