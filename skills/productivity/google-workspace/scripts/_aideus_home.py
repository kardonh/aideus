"""Resolve AIDEUS_HOME for standalone skill scripts.

Skill scripts may run outside the Aideus process (e.g. system Python,
nix env, CI) where ``aideus_constants`` is not importable.  This module
provides the same ``get_aideus_home()`` and ``display_aideus_home()``
contracts as ``aideus_constants`` without requiring it on ``sys.path``.

When ``aideus_constants`` IS available it is used directly so that any
future enhancements (profile resolution, Docker detection, etc.) are
picked up automatically.  The fallback path replicates the core logic
from ``aideus_constants.py`` using only the stdlib.

All scripts under ``google-workspace/scripts/`` should import from here
instead of duplicating the ``AIDEUS_HOME = Path(os.getenv(...))`` pattern.
"""

from __future__ import annotations

import os
from pathlib import Path

try:
    from aideus_constants import display_aideus_home as display_aideus_home
    from aideus_constants import get_aideus_home as get_aideus_home
except (ModuleNotFoundError, ImportError):

    def get_aideus_home() -> Path:
        """Return the Aideus home directory (default: ~/.aideus).

        Mirrors ``aideus_constants.get_aideus_home()``."""
        val = os.environ.get("AIDEUS_HOME", "").strip()
        return Path(val) if val else Path.home() / ".aideus"

    def display_aideus_home() -> str:
        """Return a user-friendly ``~/``-shortened display string.

        Mirrors ``aideus_constants.display_aideus_home()``."""
        home = get_aideus_home()
        try:
            return "~/" + str(home.relative_to(Path.home()))
        except ValueError:
            return str(home)
