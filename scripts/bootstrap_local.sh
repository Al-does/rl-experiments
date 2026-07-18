#!/usr/bin/env bash
# One-shot setup: ensure the shared rl-harness library sits beside this repo,
# then editable-install it into this experiment environment.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PARENT="$(dirname "$ROOT")"
LIB_LINK="$PARENT/rl-harness"
LIB_SPACED="$PARENT/RL Harness"
LIB_CLONE="$PARENT/rl-harness"
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
  echo "    into     $LIB_CLONE"
  git clone "$LIBRARY_URL" "$LIB_CLONE"
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
echo "  Rename this repo (or use GitHub 'Use this template') for your own science."
echo "  Library edits belong in $LIB_LINK (branch + PR)."
echo "  Experiment edits belong in this repo."
