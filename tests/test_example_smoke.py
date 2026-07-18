"""Sanity checks for the template example recipe."""

from __future__ import annotations

import importlib


def test_example_smoke_recipe_imports():
    module = importlib.import_module(
        "experiments.example_study.smoke.experiment"
    )
    assert callable(module.run)
    assert callable(module.build_config)
