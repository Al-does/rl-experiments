# rl-experiments

**Start here** if you are new to this stack.

This is a composition-first harness for reproducible RL research.

- The primary goal is rapid code contribution from coding agents, in a way that
  thoughtfully controls slop and affords human review. Package-level
  `AGENTS.md` files guide agents so they compose existing, tested functionality
  instead of polluting the codebase.
- The secondary goal is careful tracking of experimental results and
  reproducibility — down to commit and seed.

It is built on RLlib, so you inherit its scalability and pre-built features,
while still composing most RL concepts for fast experiment design and
prototyping. Optional [vast.ai](https://vast.ai) tooling is available if you
have an API key, for cheaper parallel GPU runs.

Under the hood there are two git repositories:

| Repo | Role |
|---|---|
| **This repo (`rl-experiments`)** | Your science: experiment recipes, findings, compact `results/` |
| [`rl-harness`](https://github.com/Al-does/RL-Harness) | Shared library: `harness/`, `learners/`, `losses/`, `envs/`, `analysis/`, `devops/` |

You fork this repo and keep working under the name `rl-experiments`. Bootstrap
clones `rl-harness` beside it automatically. You do not rename anything.

## Fork and set up

1. **Fork** this repository on GitHub (your copy keeps the name
   `rl-experiments` — no rename).
2. Clone *your* fork:

   ```bash
   git clone https://github.com/<you>/rl-experiments.git
   cd rl-experiments
   ```

3. Bootstrap — clones [`rl-harness`](https://github.com/Al-does/RL-Harness)
   beside this repo if needed, then editable-installs it:

   ```bash
   ./scripts/bootstrap_local.sh
   ```

   Layout after bootstrap:

   ```text
   parent/
     rl-harness/        # shared library (cloned by bootstrap)
     rl-experiments/    # your fork (science lives here)
   ```

4. Smoke-check the wiring:

   ```bash
   uv run rl-harness experiments.example_study.smoke.experiment --smoke
   ```

5. Replace `experiments/example_study/` with your own studies.

Requires [uv](https://docs.astral.sh/uv/) and Python 3.13+.

## Stay on library `main`

```bash
git -C ../rl-harness pull
```

Until the API stabilizes there are no version tags — pull often. Each run
manifest records the experiment-repo commit and the library commit you used.

## What to commit where (read this)

| Change | Where |
|---|---|
| Experiment recipes, findings, compact `results/` | **Your fork** — push there |
| Reusable library code (`harness/`, `learners/`, `losses/`, …) | [`rl-harness`](https://github.com/Al-does/RL-Harness) — branch + PR |
| Fixes to this starter itself (bootstrap, example smoke, docs) | Optional small PR back to **upstream** `rl-experiments` |

**Do not open science PRs back to upstream `rl-experiments`.** Your research
stays on your fork. Only optional starter/docs fixes belong upstream. Library
work always goes to `rl-harness` PRs.

A change that touches both science and the library needs **two** commits (one
per repo).

## Run an experiment

```bash
uv run rl-harness experiments.<study>.<condition>.experiment --smoke
```

Runtime flags include `--seed`, `--smoke`, `--resume-from`, and
`--hardware-profile`. Scientific hyperparameters live in the recipe, not the
CLI. Compact outputs go under `results/<run-id>/`; large/raw data under ignored
`artifacts/<run-id>/`.

## vast.ai (optional)

```bash
uv run --group devops python -m devops.vast.provision up -n 1 --dry-run
```

Boxes clone **your fork** (results push target) and `rl-harness` as siblings.
Point provisioning at your fork’s URL. Details:
[`rl-harness` vast README](https://github.com/Al-does/RL-Harness/blob/main/devops/vast/README.md).

## More architecture detail

Once you are set up, the library docs are the deep reference:

- [`rl-harness` README](https://github.com/Al-does/RL-Harness)
- [Multi-repo workflow](https://github.com/Al-does/RL-Harness/blob/main/docs/multi_repo.md)
