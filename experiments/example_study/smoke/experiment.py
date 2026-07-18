"""Minimal PPO smoke recipe so a fresh template checkout can prove the wiring."""

from __future__ import annotations

import gymnasium as gym
import numpy as np
from ray.rllib.algorithms.ppo import PPOConfig

from harness.context import RunContext
from harness.runners import run_tune


class TinyEnv(gym.Env):
    """Deterministic toy task; replace with a real env for science."""

    metadata = {"render_modes": []}
    observation_space = gym.spaces.Box(
        low=-1.0, high=1.0, shape=(4,), dtype=np.float32
    )
    action_space = gym.spaces.Discrete(2)

    def __init__(self, config=None):
        self._step = 0

    def reset(self, *, seed=None, options=None):
        super().reset(seed=seed)
        self._step = 0
        return np.zeros(4, dtype=np.float32), {}

    def step(self, action):
        self._step += 1
        observation = np.full(4, self._step / 4, dtype=np.float32)
        terminated = self._step >= 4
        reward = float(action == self._step % 2)
        return observation, reward, terminated, False, {}


def build_config(context: RunContext) -> PPOConfig:
    return (
        PPOConfig()
        .environment(TinyEnv)
        .env_runners(num_env_runners=0, num_envs_per_env_runner=1)
        .learners(num_learners=0, num_gpus_per_learner=0)
        .training(
            train_batch_size_per_learner=32,
            minibatch_size=16,
            num_epochs=1,
        )
        .debugging(seed=context.seed)
    )


def run(context: RunContext):
    iterations = 1 if context.smoke else 10
    return run_tune(
        build_config(context),
        context,
        stop={"training_iteration": iterations},
        run_config_kwargs={"verbose": 0},
    )
