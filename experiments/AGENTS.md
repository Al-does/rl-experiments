# `experiments/` — complete scientific recipes

This repository is your composition root. It editable-depends on the shared
`rl-harness` library. Generic library packages must never import experiments.

## Layout

```text
experiments/study_name/
  shared.py                 # optional family helpers
  condition_name/
    experiment.py           # required: def run(context)
    results/                # compact, reviewable outputs
    artifacts/              # large/raw; gitignored
```

## Promotion

Configure library components first. If you need a reusable RL concept, implement
it in the sibling `rl-harness` checkout and open a PR there. Keep only small
adapters and idiosyncratic science here.
