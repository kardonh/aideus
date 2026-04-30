"""Shared helpers for direct xAI HTTP integrations."""

from __future__ import annotations


def aideus_xai_user_agent() -> str:
    """Return a stable Aideus-specific User-Agent for xAI HTTP calls."""
    try:
        from aideus_cli import __version__
    except Exception:
        __version__ = "unknown"
    return f"Aideus-Agent/{__version__}"
