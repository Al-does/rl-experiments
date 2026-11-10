import jax
import jax.numpy as jnp
import numpy as np
import optax


def test_jitted_optimizer_step_reduces_loss():
    optimizer = optax.adam(learning_rate=0.1)
    params = jnp.array([1.0, -2.0])
    state = optimizer.init(params)

    @jax.jit
    def step(params, state):
        loss, grads = jax.value_and_grad(lambda values: jnp.sum(values**2))(params)
        updates, state = optimizer.update(grads, state, params)
        return optax.apply_updates(params, updates), state, loss

    updated, _, loss = step(params, state)
    assert float(jnp.sum(updated**2).block_until_ready()) < float(loss)
    np.testing.assert_allclose(updated, [0.9, -1.9], atol=1e-5)


def test_vectorized_seeded_sampling_is_reproducible():
    keys = jax.random.split(jax.random.key(42), 4)
    sample = jax.jit(jax.vmap(lambda key: jax.random.normal(key, (3,))))
    first = sample(keys).block_until_ready()
    second = sample(keys).block_until_ready()
    assert first.shape == (4, 3)
    np.testing.assert_array_equal(first, second)
    assert not np.array_equal(first[0], first[1])
