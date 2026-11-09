from pathlib import Path
import tomllib


ROOT = Path(__file__).resolve().parents[1]


def test_python_version_selects_supported_minor():
    assert (ROOT / ".python-version").read_text().strip() == "3.13"
    project = tomllib.loads((ROOT / "pyproject.toml").read_text())
    assert project["project"]["requires-python"] == ">=3.13,<3.14"


def test_lockfile_matches_project_python_requirement():
    project = tomllib.loads((ROOT / "pyproject.toml").read_text())
    lock = tomllib.loads((ROOT / "uv.lock").read_text())
    assert lock["requires-python"] in {
        project["project"]["requires-python"],
        "==3.13.*",
    }
    package = next(
        p for p in lock["package"] if p["name"] == project["project"]["name"]
    )
    assert package["source"] == {"editable": "."}
