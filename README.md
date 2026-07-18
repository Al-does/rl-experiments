# rl-experiments-template

Starter **personal experiment repo** for the shared
[`rl-harness`](https://github.com/Al-does/RL-Harness) library.

Use this as a GitHub template (or clone it), rename it to something like
`jane-rl-experiments`, then keep your science here. Reusable library changes
go upstream as PRs to `rl-harness`.

## Quick start

```bash
# From GitHub: Code → Use this template → create your private repo, then:
git clone https://github.com/<you>/<your-experiments>.git
cd <your-experiments>

# Clones rl-harness beside this repo (if missing) and editable-installs it
./scripts/bootstrap_local.sh
```

That produces:

```text
parent/
  rl-harness/                 # shared library (cloned by bootstrap)
  <your-experiments>/         # this repo
```

## Run the example

```bash
uv run rl-harness experiments.example_study.smoke.experiment --smoke
```

Replace `experiments/example_study/` with your own study leaves.

## Stay on library `main`

```bash
git -C ../rl-harness pull
```

Until the API stabilizes there are no version tags — pull often. Run manifests
record the library commit you actually used.

## Where to commit

| Change | Where |
|---|---|
| Recipes, findings, compact `results/` | this repo |
| `harness/`, `learners/`, `losses/`, `envs/`, `analysis/`, `devops/` | sibling `rl-harness` (branch + PR) |

A change that touches both needs **two** commits (one per repo).

## vast.ai

```bash
uv run --group devops python -m devops.vast.provision up -n 1 --dry-run
```

Boxes clone **this** experiment repo (results push target) and the library as
siblings. See `rl-harness` `devops/vast/README.md`.
