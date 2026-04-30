---
sidebar_position: 1
title: "CLI Commands Reference"
description: "Authoritative reference for Aideus terminal commands and command families"
---

# CLI Commands Reference

This page covers the **terminal commands** you run from your shell.

For in-chat slash commands, see [Slash Commands Reference](./slash-commands.md).

## Global entrypoint

```bash
aideus [global-options] <command> [subcommand/options]
```

### Global options

| Option | Description |
|--------|-------------|
| `--version`, `-V` | Show version and exit. |
| `--profile <name>`, `-p <name>` | Select which Aideus profile to use for this invocation. Overrides the sticky default set by `aideus profile use`. |
| `--resume <session>`, `-r <session>` | Resume a previous session by ID or title. |
| `--continue [name]`, `-c [name]` | Resume the most recent session, or the most recent session matching a title. |
| `--worktree`, `-w` | Start in an isolated git worktree for parallel-agent workflows. |
| `--yolo` | Bypass dangerous-command approval prompts. |
| `--pass-session-id` | Include the session ID in the agent's system prompt. |
| `--ignore-user-config` | Ignore `~/.aideus/config.yaml` and fall back to built-in defaults. Credentials in `.env` are still loaded. |
| `--ignore-rules` | Skip auto-injection of `AGENTS.md`, `SOUL.md`, `.cursorrules`, memory, and preloaded skills. |
| `--tui` | Launch the [TUI](../user-guide/tui.md) instead of the classic CLI. Equivalent to `AIDEUS_TUI=1`. |
| `--dev` | With `--tui`: run the TypeScript sources directly via `tsx` instead of the prebuilt bundle (for TUI contributors). |

## Top-level commands

| Command | Purpose |
|---------|---------|
| `aideus chat` | Interactive or one-shot chat with the agent. |
| `aideus model` | Interactively choose the default provider and model. |
| `aideus fallback` | Manage fallback providers tried when the primary model errors. |
| `aideus gateway` | Run or manage the messaging gateway service. |
| `aideus setup` | Interactive setup wizard for all or part of the configuration. |
| `aideus whatsapp` | Configure and pair the WhatsApp bridge. |
| `aideus slack` | Slack helpers (currently: generate the app manifest with every command as a native slash). |
| `aideus auth` | Manage credentials — add, list, remove, reset, set strategy. Handles OAuth flows for Codex/Nous/Anthropic. |
| `aideus login` / `logout` | **Deprecated** — use `aideus auth` instead. |
| `aideus status` | Show agent, auth, and platform status. |
| `aideus cron` | Inspect and tick the cron scheduler. |
| `aideus webhook` | Manage dynamic webhook subscriptions for event-driven activation. |
| `aideus hooks` | Inspect, approve, or remove shell-script hooks declared in `config.yaml`. |
| `aideus doctor` | Diagnose config and dependency issues. |
| `aideus dump` | Copy-pasteable setup summary for support/debugging. |
| `aideus debug` | Debug tools — upload logs and system info for support. |
| `aideus backup` | Back up Aideus home directory to a zip file. |
| `aideus import` | Restore a Aideus backup from a zip file. |
| `aideus logs` | View, tail, and filter agent/gateway/error log files. |
| `aideus config` | Show, edit, migrate, and query configuration files. |
| `aideus pairing` | Approve or revoke messaging pairing codes. |
| `aideus skills` | Browse, install, publish, audit, and configure skills. |
| `aideus curator` | Background skill maintenance — status, run, pause, pin. See [Curator](../user-guide/features/curator.md). |
| `aideus memory` | Configure external memory provider. Plugin-specific subcommands (e.g. `aideus honcho`) register automatically when their provider is active. |
| `aideus acp` | Run Aideus as an ACP server for editor integration. |
| `aideus mcp` | Manage MCP server configurations and run Aideus as an MCP server. |
| `aideus plugins` | Manage Aideus Agent plugins (install, enable, disable, remove). |
| `aideus tools` | Configure enabled tools per platform. |
| `aideus sessions` | Browse, export, prune, rename, and delete sessions. |
| `aideus insights` | Show token/cost/activity analytics. |
| `aideus fallback` | Interactive manager for the fallback provider chain. |
| `aideus claw` | OpenClaw migration helpers. |
| `aideus dashboard` | Launch the web dashboard for managing config, API keys, and sessions. |
| `aideus profile` | Manage profiles — multiple isolated Aideus instances. |
| `aideus completion` | Print shell completion scripts (bash/zsh/fish). |
| `aideus version` | Show version information. |
| `aideus update` | Pull latest code and reinstall dependencies. `--check` prints commit diff without pulling; `--backup` takes a pre-pull `AIDEUS_HOME` snapshot. |
| `aideus uninstall` | Remove Aideus from the system. |

## `aideus chat`

```bash
aideus chat [options]
```

Common options:

| Option | Description |
|--------|-------------|
| `-q`, `--query "..."` | One-shot, non-interactive prompt. |
| `-m`, `--model <model>` | Override the model for this run. |
| `-t`, `--toolsets <csv>` | Enable a comma-separated set of toolsets. |
| `--provider <provider>` | Force a provider: `auto`, `openrouter`, `nous`, `openai-codex`, `copilot-acp`, `copilot`, `anthropic`, `gemini`, `google-gemini-cli`, `huggingface`, `zai`, `kimi-coding`, `kimi-coding-cn`, `minimax`, `minimax-cn`, `minimax-oauth`, `kilocode`, `xiaomi`, `arcee`, `gmi`, `alibaba`, `alibaba-coding-plan` (alias `alibaba_coding`), `deepseek`, `nvidia`, `ollama-cloud`, `xai` (alias `grok`), `qwen-oauth`, `bedrock`, `opencode-zen`, `opencode-go`, `ai-gateway`, `azure-foundry`, `tencent-tokenhub` (alias `tencent`, `tokenhub`). |
| `-s`, `--skills <name>` | Preload one or more skills for the session (can be repeated or comma-separated). |
| `-v`, `--verbose` | Verbose output. |
| `-Q`, `--quiet` | Programmatic mode: suppress banner/spinner/tool previews. |
| `--image <path>` | Attach a local image to a single query. |
| `--resume <session>` / `--continue [name]` | Resume a session directly from `chat`. |
| `--worktree` | Create an isolated git worktree for this run. |
| `--checkpoints` | Enable filesystem checkpoints before destructive file changes. |
| `--yolo` | Skip approval prompts. |
| `--pass-session-id` | Pass the session ID into the system prompt. |
| `--ignore-user-config` | Ignore `~/.aideus/config.yaml` and use built-in defaults. Credentials in `.env` are still loaded. Useful for isolated CI runs, reproducible bug reports, and third-party integrations. |
| `--ignore-rules` | Skip auto-injection of `AGENTS.md`, `SOUL.md`, `.cursorrules`, persistent memory, and preloaded skills. Combine with `--ignore-user-config` for a fully isolated run. |
| `--source <tag>` | Session source tag for filtering (default: `cli`). Use `tool` for third-party integrations that should not appear in user session lists. |
| `--max-turns <N>` | Maximum tool-calling iterations per conversation turn (default: 90, or `agent.max_turns` in config). |

Examples:

```bash
aideus
aideus chat -q "Summarize the latest PRs"
aideus chat --provider openrouter --model anthropic/claude-sonnet-4.6
aideus chat --toolsets web,terminal,skills
aideus chat --quiet -q "Return only JSON"
aideus chat --worktree -q "Review this repo and open a PR"
aideus chat --ignore-user-config --ignore-rules -q "Repro without my personal setup"
```

### `aideus -z <prompt>` — scripted one-shot

For programmatic callers (shell scripts, CI, cron, parent processes piping in a prompt), `aideus -z` is the purest one-shot entry point: **single prompt in, final response text out, nothing else on stdout or stderr.** No banner, no spinner, no tool previews, no `Session:` line — just the agent's final reply as plain text.

```bash
aideus -z "What's the capital of France?"
# → Paris.

# Parent scripts can cleanly capture the response:
answer=$(aideus -z "summarize this" < /path/to/file.txt)
```

Per-run overrides (no mutation to `~/.aideus/config.yaml`):

| Flag | Equivalent env var | Purpose |
|---|---|---|
| `-m` / `--model <model>` | `AIDEUS_INFERENCE_MODEL` | Override the model for this run |
| `--provider <provider>` | `AIDEUS_INFERENCE_PROVIDER` | Override the provider for this run |

```bash
aideus -z "…" --provider openrouter --model openai/gpt-5.5
# or:
AIDEUS_INFERENCE_MODEL=anthropic/claude-sonnet-4.6 aideus -z "…"
```

Same agent, same tools, same skills — just strips every interactive / cosmetic layer. If you need tool output in the transcript too, use `aideus chat -q` instead; `-z` is explicitly for "I only want the final answer".

## `aideus model`

Interactive provider + model selector. **This is the command for adding new providers, setting up API keys, and running OAuth flows.** Run it from your terminal — not from inside an active Aideus chat session.

```bash
aideus model
```

Use this when you want to:
- **add a new provider** (OpenRouter, Anthropic, Copilot, DeepSeek, custom, etc.)
- log into OAuth-backed providers (Anthropic, Copilot, Codex, Nous Portal)
- enter or update API keys
- pick from provider-specific model lists
- configure a custom/self-hosted endpoint
- save the new default into config

:::warning aideus model vs /model — know the difference
**`aideus model`** (run from your terminal, outside any Aideus session) is the **full provider setup wizard**. It can add new providers, run OAuth flows, prompt for API keys, and configure endpoints.

**`/model`** (typed inside an active Aideus chat session) can only **switch between providers and models you've already set up**. It cannot add new providers, run OAuth, or prompt for API keys.

**If you need to add a new provider:** Exit your Aideus session first (`Ctrl+C` or `/quit`), then run `aideus model` from your terminal prompt.
:::

### `/model` slash command (mid-session)

Switch between already-configured models without leaving a session:

```
/model                              # Show current model and available options
/model claude-sonnet-4              # Switch model (auto-detects provider)
/model zai:glm-5                    # Switch provider and model
/model custom:qwen-2.5              # Use model on your custom endpoint
/model custom                       # Auto-detect model from custom endpoint
/model custom:local:qwen-2.5        # Use a named custom provider
/model openrouter:anthropic/claude-sonnet-4  # Switch back to cloud
```

By default, `/model` changes apply **to the current session only**. Add `--global` to persist the change to `config.yaml`:

```
/model claude-sonnet-4 --global     # Switch and save as new default
```

:::info What if I only see OpenRouter models?
If you've only configured OpenRouter, `/model` will only show OpenRouter models. To add another provider (Anthropic, DeepSeek, Copilot, etc.), exit your session and run `aideus model` from the terminal.
:::

Provider and base URL changes are persisted to `config.yaml` automatically. When switching away from a custom endpoint, the stale base URL is cleared to prevent it leaking into other providers.

## `aideus gateway`

```bash
aideus gateway <subcommand>
```

Subcommands:

| Subcommand | Description |
|------------|-------------|
| `run` | Run the gateway in the foreground. Recommended for WSL, Docker, and Termux. |
| `start` | Start the installed systemd/launchd background service. |
| `stop` | Stop the service (or foreground process). |
| `restart` | Restart the service. |
| `status` | Show service status. |
| `install` | Install as a systemd (Linux) or launchd (macOS) background service. |
| `uninstall` | Remove the installed service. |
| `setup` | Interactive messaging-platform setup. |

Options:

| Option | Description |
|--------|-------------|
| `--all` | On `start` / `restart` / `stop`: act on **every profile's** gateway, not just the active `AIDEUS_HOME`. Useful if you run multiple profiles side-by-side and want to restart them all after `aideus update`. |

:::tip WSL users
Use `aideus gateway run` instead of `aideus gateway start` — WSL's systemd support is unreliable. Wrap it in tmux for persistence: `tmux new -s aideus 'aideus gateway run'`. See [WSL FAQ](/docs/reference/faq#wsl-gateway-keeps-disconnecting-or-aideus-gateway-start-fails) for details.
:::

## `aideus setup`

```bash
aideus setup [model|tts|terminal|gateway|tools|agent] [--non-interactive] [--reset] [--quick] [--reconfigure]
```

**First run:** launches the first-time wizard.

**Returning user (already configured):** drops straight into the full reconfigure wizard — every prompt shows your current value as its default, press Enter to keep or type a new value. No menu.

Jump into one section instead of the full wizard:

| Section | Description |
|---------|-------------|
| `model` | Provider and model setup. |
| `terminal` | Terminal backend and sandbox setup. |
| `gateway` | Messaging platform setup. |
| `tools` | Enable/disable tools per platform. |
| `agent` | Agent behavior settings. |

Options:

| Option | Description |
|--------|-------------|
| `--quick` | On returning-user runs: only prompt for items that are missing or unset. Skip items you already have configured. |
| `--non-interactive` | Use defaults / environment values without prompts. |
| `--reset` | Reset configuration to defaults before setup. |
| `--reconfigure` | Backwards-compat alias — bare `aideus setup` on an existing install now does this by default. |

## `aideus whatsapp`

```bash
aideus whatsapp
```

Runs the WhatsApp pairing/setup flow, including mode selection and QR-code pairing.

## `aideus slack`

```bash
aideus slack manifest              # print manifest to stdout
aideus slack manifest --write      # write to ~/.aideus/slack-manifest.json
aideus slack manifest --slashes-only  # just the features.slash_commands array
```

Generates a Slack app manifest that registers every gateway command in
`COMMAND_REGISTRY` (`/btw`, `/stop`, `/model`, …) as a first-class
Slack slash command — matching Discord and Telegram parity. Paste the
output into your Slack app config at
[https://api.slack.com/apps](https://api.slack.com/apps) → your app →
**Features → App Manifest → Edit**, then **Save**. Slack prompts for
reinstall if scopes or slash commands changed.

| Flag | Default | Purpose |
|------|---------|---------|
| `--write [PATH]` | stdout | Write to a file instead of stdout. Bare `--write` writes `$AIDEUS_HOME/slack-manifest.json`. |
| `--name NAME` | `Aideus` | Bot display name in Slack. |
| `--description DESC` | default blurb | Bot description shown in the Slack app directory. |
| `--slashes-only` | off | Emit only `features.slash_commands` for merging into a manually-maintained manifest. |

Run `aideus slack manifest --write` again after `aideus update` to pick
up any new commands.


## `aideus login` / `aideus logout` *(Deprecated)*

:::caution
`aideus login` has been removed. Use `aideus auth` to manage OAuth credentials, `aideus model` to select a provider, or `aideus setup` for full interactive setup.
:::

## `aideus auth`

Manage credential pools for same-provider key rotation. See [Credential Pools](/docs/user-guide/features/credential-pools) for full documentation.

```bash
aideus auth                                              # Interactive wizard
aideus auth list                                         # Show all pools
aideus auth list openrouter                              # Show specific provider
aideus auth add openrouter --api-key sk-or-v1-xxx        # Add API key
aideus auth add anthropic --type oauth                   # Add OAuth credential
aideus auth remove openrouter 2                          # Remove by index
aideus auth reset openrouter                             # Clear cooldowns
```

Subcommands: `add`, `list`, `remove`, `reset`. When called with no subcommand, launches the interactive management wizard.

## `aideus status`

```bash
aideus status [--all] [--deep]
```

| Option | Description |
|--------|-------------|
| `--all` | Show all details in a shareable redacted format. |
| `--deep` | Run deeper checks that may take longer. |

## `aideus cron`

```bash
aideus cron <list|create|edit|pause|resume|run|remove|status|tick>
```

| Subcommand | Description |
|------------|-------------|
| `list` | Show scheduled jobs. |
| `create` / `add` | Create a scheduled job from a prompt, optionally attaching one or more skills via repeated `--skill`. |
| `edit` | Update a job's schedule, prompt, name, delivery, repeat count, or attached skills. Supports `--clear-skills`, `--add-skill`, and `--remove-skill`. |
| `pause` | Pause a job without deleting it. |
| `resume` | Resume a paused job and compute its next future run. |
| `run` | Trigger a job on the next scheduler tick. |
| `remove` | Delete a scheduled job. |
| `status` | Check whether the cron scheduler is running. |
| `tick` | Run due jobs once and exit. |

## `aideus webhook`

```bash
aideus webhook <subscribe|list|remove|test>
```

Manage dynamic webhook subscriptions for event-driven agent activation. Requires the webhook platform to be enabled in config — if not configured, prints setup instructions.

| Subcommand | Description |
|------------|-------------|
| `subscribe` / `add` | Create a webhook route. Returns the URL and HMAC secret to configure on your service. |
| `list` / `ls` | Show all agent-created subscriptions. |
| `remove` / `rm` | Delete a dynamic subscription. Static routes from config.yaml are not affected. |
| `test` | Send a test POST to verify a subscription is working. |

### `aideus webhook subscribe`

```bash
aideus webhook subscribe <name> [options]
```

| Option | Description |
|--------|-------------|
| `--prompt` | Prompt template with `{dot.notation}` payload references. |
| `--events` | Comma-separated event types to accept (e.g. `issues,pull_request`). Empty = all. |
| `--description` | Human-readable description. |
| `--skills` | Comma-separated skill names to load for the agent run. |
| `--deliver` | Delivery target: `log` (default), `telegram`, `discord`, `slack`, `github_comment`. |
| `--deliver-chat-id` | Target chat/channel ID for cross-platform delivery. |
| `--secret` | Custom HMAC secret. Auto-generated if omitted. |

Subscriptions persist to `~/.aideus/webhook_subscriptions.json` and are hot-reloaded by the webhook adapter without a gateway restart.

## `aideus doctor`

```bash
aideus doctor [--fix]
```

| Option | Description |
|--------|-------------|
| `--fix` | Attempt automatic repairs where possible. |

## `aideus dump`

```bash
aideus dump [--show-keys]
```

Outputs a compact, plain-text summary of your entire Aideus setup. Designed to be copy-pasted into Discord, GitHub issues, or Telegram when asking for support — no ANSI colors, no special formatting, just data.

| Option | Description |
|--------|-------------|
| `--show-keys` | Show redacted API key prefixes (first and last 4 characters) instead of just `set`/`not set`. |

### What it includes

| Section | Details |
|---------|---------|
| **Header** | Aideus version, release date, git commit hash |
| **Environment** | OS, Python version, OpenAI SDK version |
| **Identity** | Active profile name, AIDEUS_HOME path |
| **Model** | Configured default model and provider |
| **Terminal** | Backend type (local, docker, ssh, etc.) |
| **API keys** | Presence check for all 22 provider/tool API keys |
| **Features** | Enabled toolsets, MCP server count, memory provider |
| **Services** | Gateway status, configured messaging platforms |
| **Workload** | Cron job counts, installed skill count |
| **Config overrides** | Any config values that differ from defaults |

### Example output

```
--- aideus dump ---
version:          0.8.0 (2026.4.8) [af4abd2f]
os:               Linux 6.14.0-37-generic x86_64
python:           3.11.14
openai_sdk:       2.24.0
profile:          default
aideus_home:      ~/.aideus
model:            anthropic/claude-opus-4.6
provider:         openrouter
terminal:         local

api_keys:
  openrouter           set
  openai               not set
  anthropic            set
  nous                 not set
  firecrawl            set
  ...

features:
  toolsets:           all
  mcp_servers:        0
  memory_provider:    built-in
  gateway:            running (systemd)
  platforms:          telegram, discord
  cron_jobs:          3 active / 5 total
  skills:             42

config_overrides:
  agent.max_turns: 250
  compression.threshold: 0.85
  display.streaming: True
--- end dump ---
```

### When to use

- Reporting a bug on GitHub — paste the dump into your issue
- Asking for help in Discord — share it in a code block
- Comparing your setup to someone else's
- Quick sanity check when something isn't working

:::tip
`aideus dump` is specifically designed for sharing. For interactive diagnostics, use `aideus doctor`. For a visual overview, use `aideus status`.
:::

## `aideus debug`

```bash
aideus debug share [options]
```

Upload a debug report (system info + recent logs) to a paste service and get a shareable URL. Useful for quick support requests — includes everything a helper needs to diagnose your issue.

| Option | Description |
|--------|-------------|
| `--lines <N>` | Number of log lines to include per log file (default: 200). |
| `--expire <days>` | Paste expiry in days (default: 7). |
| `--local` | Print the report locally instead of uploading. |

The report includes system info (OS, Python version, Aideus version), recent agent and gateway logs (512 KB limit per file), and redacted API key status. Keys are always redacted — no secrets are uploaded.

Paste services tried in order: paste.rs, dpaste.com.

### Examples

```bash
aideus debug share              # Upload debug report, print URL
aideus debug share --lines 500  # Include more log lines
aideus debug share --expire 30  # Keep paste for 30 days
aideus debug share --local      # Print report to terminal (no upload)
```

## `aideus backup`

```bash
aideus backup [options]
```

Create a zip archive of your Aideus configuration, skills, sessions, and data. The backup excludes the aideus-agent codebase itself.

| Option | Description |
|--------|-------------|
| `-o`, `--output <path>` | Output path for the zip file (default: `~/aideus-backup-<timestamp>.zip`). |
| `-q`, `--quick` | Quick snapshot: only critical state files (config.yaml, state.db, .env, auth, cron jobs). Much faster than a full backup. |
| `-l`, `--label <name>` | Label for the snapshot (only used with `--quick`). |

The backup uses SQLite's `backup()` API for safe copying, so it works correctly even when Aideus is running (WAL-mode safe).

**What's excluded from the zip:**

- `*.db-wal`, `*.db-shm`, `*.db-journal` — SQLite's WAL / shared-memory / journal sidecars. The `*.db` file already got a consistent snapshot via `sqlite3.backup()`; shipping the live sidecars alongside it would let a restore see a half-committed state.
- `checkpoints/` — per-session trajectory caches. Hash-keyed and regenerated per session; wouldn't port cleanly to another install anyway.
- The `aideus-agent` code itself (this is a user-data backup, not a repo snapshot).

### Examples

```bash
aideus backup                           # Full backup to ~/aideus-backup-*.zip
aideus backup -o /tmp/aideus.zip        # Full backup to specific path
aideus backup --quick                   # Quick state-only snapshot
aideus backup --quick --label "pre-upgrade"  # Quick snapshot with label
```

## `aideus import`

```bash
aideus import <zipfile> [options]
```

Restore a previously created Aideus backup into your Aideus home directory.

| Option | Description |
|--------|-------------|
| `-f`, `--force` | Overwrite existing files without confirmation. |

## `aideus logs`

```bash
aideus logs [log_name] [options]
```

View, tail, and filter Aideus log files. All logs are stored in `~/.aideus/logs/` (or `<profile>/logs/` for non-default profiles).

### Log files

| Name | File | What it captures |
|------|------|-----------------|
| `agent` (default) | `agent.log` | All agent activity — API calls, tool dispatch, session lifecycle (INFO and above) |
| `errors` | `errors.log` | Warnings and errors only — a filtered subset of agent.log |
| `gateway` | `gateway.log` | Messaging gateway activity — platform connections, message dispatch, webhook events |

### Options

| Option | Description |
|--------|-------------|
| `log_name` | Which log to view: `agent` (default), `errors`, `gateway`, or `list` to show available files with sizes. |
| `-n`, `--lines <N>` | Number of lines to show (default: 50). |
| `-f`, `--follow` | Follow the log in real time, like `tail -f`. Press Ctrl+C to stop. |
| `--level <LEVEL>` | Minimum log level to show: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`. |
| `--session <ID>` | Filter lines containing a session ID substring. |
| `--since <TIME>` | Show lines from a relative time ago: `30m`, `1h`, `2d`, etc. Supports `s` (seconds), `m` (minutes), `h` (hours), `d` (days). |
| `--component <NAME>` | Filter by component: `gateway`, `agent`, `tools`, `cli`, `cron`. |

### Examples

```bash
# View the last 50 lines of agent.log (default)
aideus logs

# Follow agent.log in real time
aideus logs -f

# View the last 100 lines of gateway.log
aideus logs gateway -n 100

# Show only warnings and errors from the last hour
aideus logs --level WARNING --since 1h

# Filter by a specific session
aideus logs --session abc123

# Follow errors.log, starting from 30 minutes ago
aideus logs errors --since 30m -f

# List all log files with their sizes
aideus logs list
```

### Filtering

Filters can be combined. When multiple filters are active, a log line must pass **all** of them to be shown:

```bash
# WARNING+ lines from the last 2 hours containing session "tg-12345"
aideus logs --level WARNING --since 2h --session tg-12345
```

Lines without a parseable timestamp are included when `--since` is active (they may be continuation lines from a multi-line log entry). Lines without a detectable level are included when `--level` is active.

### Log rotation

Aideus uses Python's `RotatingFileHandler`. Old logs are rotated automatically — look for `agent.log.1`, `agent.log.2`, etc. The `aideus logs list` subcommand shows all log files including rotated ones.

## `aideus config`

```bash
aideus config <subcommand>
```

Subcommands:

| Subcommand | Description |
|------------|-------------|
| `show` | Show current config values. |
| `edit` | Open `config.yaml` in your editor. |
| `set <key> <value>` | Set a config value. |
| `path` | Print the config file path. |
| `env-path` | Print the `.env` file path. |
| `check` | Check for missing or stale config. |
| `migrate` | Add newly introduced options interactively. |

## `aideus pairing`

```bash
aideus pairing <list|approve|revoke|clear-pending>
```

| Subcommand | Description |
|------------|-------------|
| `list` | Show pending and approved users. |
| `approve <platform> <code>` | Approve a pairing code. |
| `revoke <platform> <user-id>` | Revoke a user's access. |
| `clear-pending` | Clear pending pairing codes. |

## `aideus skills`

```bash
aideus skills <subcommand>
```

Subcommands:

| Subcommand | Description |
|------------|-------------|
| `browse` | Paginated browser for skill registries. |
| `search` | Search skill registries. |
| `install` | Install a skill. |
| `inspect` | Preview a skill without installing it. |
| `list` | List installed skills. |
| `check` | Check installed hub skills for upstream updates. |
| `update` | Reinstall hub skills with upstream changes when available. |
| `audit` | Re-scan installed hub skills. |
| `uninstall` | Remove a hub-installed skill. |
| `publish` | Publish a skill to a registry. |
| `snapshot` | Export/import skill configurations. |
| `tap` | Manage custom skill sources. |
| `config` | Interactive enable/disable configuration for skills by platform. |

Common examples:

```bash
aideus skills browse
aideus skills browse --source official
aideus skills search react --source skills-sh
aideus skills search https://mintlify.com/docs --source well-known
aideus skills inspect official/security/1password
aideus skills inspect skills-sh/vercel-labs/json-render/json-render-react
aideus skills install official/migration/openclaw-migration
aideus skills install skills-sh/anthropics/skills/pdf --force
aideus skills install https://sharethis.chat/SKILL.md                     # Direct URL (single-file SKILL.md)
aideus skills install https://example.com/SKILL.md --name my-skill        # Override name when frontmatter has none
aideus skills check
aideus skills update
aideus skills config
```

Notes:
- `--force` can override non-dangerous policy blocks for third-party/community skills.
- `--force` does not override a `dangerous` scan verdict.
- `--source skills-sh` searches the public `skills.sh` directory.
- `--source well-known` lets you point Aideus at a site exposing `/.well-known/skills/index.json`.
- Passing an `http(s)://…/*.md` URL installs a single-file SKILL.md directly. When frontmatter has no `name:` and the URL slug isn't a valid identifier, an interactive terminal prompts for a name; non-interactive surfaces (`/skills install` inside the TUI, gateway platforms) require `--name <x>` instead.

## `aideus curator`

```bash
aideus curator <subcommand>
```

The curator is an auxiliary-model background task that periodically reviews agent-created skills, prunes stale ones, consolidates overlaps, and archives obsolete skills. Bundled and hub-installed skills are never touched. Archives are recoverable; auto-deletion never happens.

| Subcommand | Description |
|------------|-------------|
| `status` | Show curator status and skill stats |
| `run` | Trigger a curator review now |
| `pause` | Pause the curator until resumed |
| `resume` | Resume a paused curator |
| `pin <skill>` | Pin a skill so the curator never auto-transitions it |
| `unpin <skill>` | Unpin a skill |
| `restore <skill>` | Restore an archived skill |

See [Curator](../user-guide/features/curator.md) for behavior and config.

## `aideus fallback`

```bash
aideus fallback <subcommand>
```

Manage the fallback provider chain. Fallback providers are tried in order when the primary model fails with rate-limit, overload, or connection errors.

| Subcommand | Description |
|------------|-------------|
| `list` (alias: `ls`) | Show the current fallback chain (default when no subcommand) |
| `add` | Pick a provider + model (same picker as `aideus model`) and append to the chain |
| `remove` (alias: `rm`) | Pick an entry to delete from the chain |
| `clear` | Remove all fallback entries |

See [Fallback Providers](../user-guide/features/fallback-providers.md).

## `aideus hooks`

```bash
aideus hooks <subcommand>
```

Inspect shell-script hooks declared in `~/.aideus/config.yaml`, test them against synthetic payloads, and manage the first-use consent allowlist at `~/.aideus/shell-hooks-allowlist.json`.

| Subcommand | Description |
|------------|-------------|
| `list` (alias: `ls`) | List configured hooks with matcher, timeout, and consent status |
| `test <event>` | Fire every hook matching `<event>` against a synthetic payload |
| `revoke` (aliases: `remove`, `rm`) | Remove a command's allowlist entries (takes effect on next restart) |
| `doctor` | Check each configured hook: exec bit, allowlist, mtime drift, JSON validity, and synthetic run timing |

See [Hooks](../user-guide/features/hooks.md) for event signatures and payload shapes.

## `aideus memory`

```bash
aideus memory <subcommand>
```

Set up and manage external memory provider plugins. Available providers: honcho, openviking, mem0, hindsight, holographic, retaindb, byterover, supermemory. Only one external provider can be active at a time. Built-in memory (MEMORY.md/USER.md) is always active.

Subcommands:

| Subcommand | Description |
|------------|-------------|
| `setup` | Interactive provider selection and configuration. |
| `status` | Show current memory provider config. |
| `off` | Disable external provider (built-in only). |

:::info Provider-specific subcommands
When an external memory provider is active, it may register its own top-level `aideus <provider>` command for provider-specific management (e.g. `aideus honcho` when Honcho is active). Inactive providers do not expose their subcommands. Run `aideus --help` to see what's currently wired in.
:::

## `aideus acp`

```bash
aideus acp
```

Starts Aideus as an ACP (Agent Client Protocol) stdio server for editor integration.

Related entrypoints:

```bash
aideus-acp
python -m acp_adapter
```

Install support first:

```bash
pip install -e '.[acp]'
```

See [ACP Editor Integration](../user-guide/features/acp.md) and [ACP Internals](../developer-guide/acp-internals.md).

## `aideus mcp`

```bash
aideus mcp <subcommand>
```

Manage MCP (Model Context Protocol) server configurations and run Aideus as an MCP server.

| Subcommand | Description |
|------------|-------------|
| `serve [-v\|--verbose]` | Run Aideus as an MCP server — expose conversations to other agents. |
| `add <name> [--url URL] [--command CMD] [--args ...] [--auth oauth\|header]` | Add an MCP server with automatic tool discovery. |
| `remove <name>` (alias: `rm`) | Remove an MCP server from config. |
| `list` (alias: `ls`) | List configured MCP servers. |
| `test <name>` | Test connection to an MCP server. |
| `configure <name>` (alias: `config`) | Toggle tool selection for a server. |

See [MCP Config Reference](./mcp-config-reference.md), [Use MCP with Aideus](../guides/use-mcp-with-aideus.md), and [MCP Server Mode](../user-guide/features/mcp.md#running-aideus-as-an-mcp-server).

## `aideus plugins`

```bash
aideus plugins [subcommand]
```

Unified plugin management — general plugins, memory providers, and context engines in one place. Running `aideus plugins` with no subcommand opens a composite interactive screen with two sections:

- **General Plugins** — multi-select checkboxes to enable/disable installed plugins
- **Provider Plugins** — single-select configuration for Memory Provider and Context Engine. Press ENTER on a category to open a radio picker.

| Subcommand | Description |
|------------|-------------|
| *(none)* | Composite interactive UI — general plugin toggles + provider plugin configuration. |
| `install <identifier> [--force]` | Install a plugin from a Git URL or `owner/repo`. |
| `update <name>` | Pull latest changes for an installed plugin. |
| `remove <name>` (aliases: `rm`, `uninstall`) | Remove an installed plugin. |
| `enable <name>` | Enable a disabled plugin. |
| `disable <name>` | Disable a plugin without removing it. |
| `list` (alias: `ls`) | List installed plugins with enabled/disabled status. |

Provider plugin selections are saved to `config.yaml`:
- `memory.provider` — active memory provider (empty = built-in only)
- `context.engine` — active context engine (`"compressor"` = built-in default)

General plugin disabled list is stored in `config.yaml` under `plugins.disabled`.

See [Plugins](../user-guide/features/plugins.md) and [Build a Aideus Plugin](../guides/build-a-aideus-plugin.md).

## `aideus tools`

```bash
aideus tools [--summary]
```

| Option | Description |
|--------|-------------|
| `--summary` | Print the current enabled-tools summary and exit. |

Without `--summary`, this launches the interactive per-platform tool configuration UI.

## `aideus sessions`

```bash
aideus sessions <subcommand>
```

Subcommands:

| Subcommand | Description |
|------------|-------------|
| `list` | List recent sessions. |
| `browse` | Interactive session picker with search and resume. |
| `export <output> [--session-id ID]` | Export sessions to JSONL. |
| `delete <session-id>` | Delete one session. |
| `prune` | Delete old sessions. |
| `stats` | Show session-store statistics. |
| `rename <session-id> <title>` | Set or change a session title. |

## `aideus insights`

```bash
aideus insights [--days N] [--source platform]
```

| Option | Description |
|--------|-------------|
| `--days <n>` | Analyze the last `n` days (default: 30). |
| `--source <platform>` | Filter by source such as `cli`, `telegram`, or `discord`. |

## `aideus claw`

```bash
aideus claw migrate [options]
```

Migrate your OpenClaw setup to Aideus. Reads from `~/.openclaw` (or a custom path) and writes to `~/.aideus`. Automatically detects legacy directory names (`~/.clawdbot`, `~/.moltbot`) and config filenames (`clawdbot.json`, `moltbot.json`).

| Option | Description |
|--------|-------------|
| `--dry-run` | Preview what would be migrated without writing anything. |
| `--preset <name>` | Migration preset: `full` (all compatible settings) or `user-data` (excludes infrastructure config). Neither preset imports secrets — pass `--migrate-secrets` explicitly. |
| `--overwrite` | Overwrite existing Aideus files on conflicts (default: refuse to apply when the plan has conflicts). |
| `--migrate-secrets` | Include API keys in migration. Required even under `--preset full`. |
| `--no-backup` | Skip the pre-migration zip snapshot of `~/.aideus/` (by default a single restore-point archive is written to `~/.aideus/backups/pre-migration-*.zip` before apply; restorable with `aideus import`). |
| `--source <path>` | Custom OpenClaw directory (default: `~/.openclaw`). |
| `--workspace-target <path>` | Target directory for workspace instructions (AGENTS.md). |
| `--skill-conflict <mode>` | Handle skill name collisions: `skip` (default), `overwrite`, or `rename`. |
| `--yes` | Skip the confirmation prompt. |

### What gets migrated

The migration covers 30+ categories across persona, memory, skills, model providers, messaging platforms, agent behavior, session policies, MCP servers, TTS, and more. Items are either **directly imported** into Aideus equivalents or **archived** for manual review.

**Directly imported:** SOUL.md, MEMORY.md, USER.md, AGENTS.md, skills (4 source directories), default model, custom providers, MCP servers, messaging platform tokens and allowlists (Telegram, Discord, Slack, WhatsApp, Signal, Matrix, Mattermost), agent defaults (reasoning effort, compression, human delay, timezone, sandbox), session reset policies, approval rules, TTS config, browser settings, tool settings, exec timeout, command allowlist, gateway config, and API keys from 3 sources.

**Archived for manual review:** Cron jobs, plugins, hooks/webhooks, memory backend (QMD), skills registry config, UI/identity, logging, multi-agent setup, channel bindings, IDENTITY.md, TOOLS.md, HEARTBEAT.md, BOOTSTRAP.md.

**API key resolution** checks three sources in priority order: config values → `~/.openclaw/.env` → `auth-profiles.json`. All token fields handle plain strings, env templates (`${VAR}`), and SecretRef objects.

For the complete config key mapping, SecretRef handling details, and post-migration checklist, see the **[full migration guide](../guides/migrate-from-openclaw.md)**.

### Examples

```bash
# Preview what would be migrated
aideus claw migrate --dry-run

# Full migration (all compatible settings, no secrets)
aideus claw migrate --preset full

# Full migration including API keys
aideus claw migrate --preset full --migrate-secrets

# Migrate user data only (no secrets), overwrite conflicts
aideus claw migrate --preset user-data --overwrite

# Migrate from a custom OpenClaw path
aideus claw migrate --source /home/user/old-openclaw
```

## `aideus dashboard`

```bash
aideus dashboard [options]
```

Launch the web dashboard — a browser-based UI for managing configuration, API keys, and monitoring sessions. Requires `pip install aideus-agent[web]` (FastAPI + Uvicorn). See [Web Dashboard](/docs/user-guide/features/web-dashboard) for full documentation.

| Option | Default | Description |
|--------|---------|-------------|
| `--port` | `9119` | Port to run the web server on |
| `--host` | `127.0.0.1` | Bind address |
| `--no-open` | — | Don't auto-open the browser |

```bash
# Default — opens browser to http://127.0.0.1:9119
aideus dashboard

# Custom port, no browser
aideus dashboard --port 8080 --no-open
```

## `aideus profile`

```bash
aideus profile <subcommand>
```

Manage profiles — multiple isolated Aideus instances, each with its own config, sessions, skills, and home directory.

| Subcommand | Description |
|------------|-------------|
| `list` | List all profiles. |
| `use <name>` | Set a sticky default profile. |
| `create <name> [--clone] [--clone-all] [--clone-from <source>] [--no-alias]` | Create a new profile. `--clone` copies config, `.env`, and `SOUL.md` from the active profile. `--clone-all` copies all state. `--clone-from` specifies a source profile. |
| `delete <name> [-y]` | Delete a profile. |
| `show <name>` | Show profile details (home directory, config, etc.). |
| `alias <name> [--remove] [--name NAME]` | Manage wrapper scripts for quick profile access. |
| `rename <old> <new>` | Rename a profile. |
| `export <name> [-o FILE]` | Export a profile to a `.tar.gz` archive. |
| `import <archive> [--name NAME]` | Import a profile from a `.tar.gz` archive. |

Examples:

```bash
aideus profile list
aideus profile create work --clone
aideus profile use work
aideus profile alias work --name h-work
aideus profile export work -o work-backup.tar.gz
aideus profile import work-backup.tar.gz --name restored
aideus -p work chat -q "Hello from work profile"
```

## `aideus completion`

```bash
aideus completion [bash|zsh|fish]
```

Print a shell completion script to stdout. Source the output in your shell profile for tab-completion of Aideus commands, subcommands, and profile names.

Examples:

```bash
# Bash
aideus completion bash >> ~/.bashrc

# Zsh
aideus completion zsh >> ~/.zshrc

# Fish
aideus completion fish > ~/.config/fish/completions/aideus.fish
```

## `aideus update`

```bash
aideus update [--check] [--backup] [--restart-gateway]
```

Pulls the latest `aideus-agent` code and reinstalls dependencies in your venv, then re-runs the post-install hooks (MCP servers, skills sync, completion install). Safe to run on a live install.

| Option | Description |
|--------|-------------|
| `--check` | Print the current commit and the latest `origin/main` commit side by side, and exit 0 if in sync or 1 if behind. Does not pull, install, or restart anything. |
| `--backup` | Create a labeled pre-update snapshot of `AIDEUS_HOME` (config, auth, sessions, skills, pairing data) before pulling. Default is **off** — the previous always-backup behavior was adding minutes to every update on large homes. Flip it on permanently via `update.backup: true` in `config.yaml`. |
| `--restart-gateway` | After a successful update, restart the running gateway service. Implies `--all` semantics if multiple profiles are installed. |

Additional behavior:

- **Pairing data snapshot.** Even when `--backup` is off, `aideus update` takes a lightweight snapshot of `~/.aideus/pairing/` and the Feishu comment rules before `git pull`. You can roll it back with `aideus backup restore --state pre-update` if a pull rewrites a file you were editing.
- **Legacy `aideus.service` warning.** If Aideus detects a pre-rename `aideus.service` systemd unit (instead of the current `aideus-gateway.service`), it prints a one-time migration hint so you can avoid flap-loop issues.
- **Exit codes.** `0` on success, `1` on pull/install/post-install errors, `2` on unexpected working-tree changes that block `git pull`.

## `aideus fallback`

```bash
aideus fallback           # interactive manager
```

Manage the fallback provider chain (used when your primary provider hits a rate limit or returns a fatal error) without hand-editing `config.yaml`. Reuses the provider picker from `aideus model` — same provider list, same credential prompts, same validation.

Typical session:

1. Press `a` to add a fallback → pick a provider (OAuth-based providers open a browser; API-key providers prompt for the key), then pick the specific model.
2. Use `↑`/`↓` to reorder fallbacks (first-in-list is tried first).
3. Press `d` to remove one.

All changes persist to `fallback_providers:` under `model:` in `config.yaml`. Interacts with [Credential Pools](/docs/user-guide/features/credential-pools): pools rotate keys *within* a provider, fallbacks switch to a *different* provider entirely.

See [Fallback Providers](/docs/user-guide/features/fallback-providers) for behavior details and interaction with `fallback_model` (legacy single-fallback key).

## Maintenance commands

| Command | Description |
|---------|-------------|
| `aideus version` | Print version information. |
| `aideus update` | Pull latest changes and reinstall dependencies. |
| `aideus uninstall [--full] [--yes]` | Remove Aideus, optionally deleting all config/data. |

## See also

- [Slash Commands Reference](./slash-commands.md)
- [CLI Interface](../user-guide/cli.md)
- [Sessions](../user-guide/sessions.md)
- [Skills System](../user-guide/features/skills.md)
- [Skins & Themes](../user-guide/features/skins.md)
