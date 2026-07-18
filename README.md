# rl-experiments

**Start here.** This is the personal experiment repo for the shared
[`rl-harness`](https://github.com/Al-does/RL-Harness) library.

## Get started (fork — do not rename)

1. **Fork** this repository on GitHub (your copy keeps the name `rl-experiments`).
2. Clone *your* fork:

   ```bash
   git clone https://github.com/<you>/rl-experiments.git
   cd rl-experiments
   ```

3. Bootstrap — clones `rl-harness` beside this repo if needed, then editable-installs it:

   ```bash
   ./scripts/bootstrap_local.sh
   ```

That produces:

```text
parent/
  rl-harness/        # shared library (cloned by bootstrap)
  rl-experiments/    # your fork (science lives here)
```

4. Smoke-check the wiring:

   ```bash
   uv run rl-harness experiments.example_study.smoke.experiment --smoke
   ```

5. Replace `experiments/example_study/` with your studies.

You do **not** need to rename the repo or the local folder. Everyone’s working
copy can simply be called `rl-experiments`.

## Stay on library `main`

```bash
git -C ../rl-harness pull
```

Until the API stabilizes there are no version tags — pull often. Run manifests
record the library commit you actually used.

## Where to commit / open PRs

| Change | Where |
|---|---|
| Recipes, findings, compact `results/` | **your fork** of this repo (push to your fork; do not open science PRs back here) |
| `harness/`, `learners/`, `losses/`, `envs/`, `analysis/`, `devops/` | [`rl-harness`](https://github.com/Al-does/RL-Harness) (branch + PR) |

A change that touches both needs **two** commits (one per repo).

This upstream `rl-experiments` stays a thin starter (example smoke recipe +
bootstrap). Optional improvements to the starter itself can be PRs back here;
your research stays on your fork.

## vast.ai

```bash
uv run --group devops python -m devops.vast.provision up -n 1 --dry-run
```

Boxes clone **your experiment fork** (results push target) and the library as
siblings. See `rl-harness` `devops/vast/README.md`. Configure the experiment
repo URL to your fork when provisioning.
