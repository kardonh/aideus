# Langfuse Observability Plugin

This plugin ships bundled with Aideus but is **opt-in** — it only loads when
you explicitly enable it.

## Enable

Pick one:

```bash
# Interactive: walks you through credentials + SDK install + enable
aideus tools  # → Langfuse Observability

# Manual
pip install langfuse
aideus plugins enable observability/langfuse
```

## Required credentials

Set these in `~/.aideus/.env` (or via `aideus tools`):

```bash
AIDEUS_LANGFUSE_PUBLIC_KEY=pk-lf-...
AIDEUS_LANGFUSE_SECRET_KEY=sk-lf-...
AIDEUS_LANGFUSE_BASE_URL=https://cloud.langfuse.com   # or your self-hosted URL
```

Without the SDK or credentials the hooks no-op silently — the plugin fails
open.

## Verify

```bash
aideus plugins list                 # observability/langfuse should show "enabled"
aideus chat -q "hello"              # then check Langfuse for a "Aideus turn" trace
```

## Optional tuning

```bash
AIDEUS_LANGFUSE_ENV=production       # environment tag
AIDEUS_LANGFUSE_RELEASE=v1.0.0       # release tag
AIDEUS_LANGFUSE_SAMPLE_RATE=0.5      # sample 50% of traces
AIDEUS_LANGFUSE_MAX_CHARS=12000      # max chars per field (default: 12000)
AIDEUS_LANGFUSE_DEBUG=true           # verbose plugin logging
```

## Disable

```bash
aideus plugins disable observability/langfuse
```
