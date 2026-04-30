---
sidebar_position: 7
---

# Profile Commands Reference

This page covers all commands related to [Aideus profiles](../user-guide/profiles.md). For general CLI commands, see [CLI Commands Reference](./cli-commands.md).

## `aideus profile`

```bash
aideus profile <subcommand>
```

Top-level command for managing profiles. Running `aideus profile` without a subcommand shows help.

| Subcommand | Description |
|------------|-------------|
| `list` | List all profiles. |
| `use` | Set the active (default) profile. |
| `create` | Create a new profile. |
| `delete` | Delete a profile. |
| `show` | Show details about a profile. |
| `alias` | Regenerate the shell alias for a profile. |
| `rename` | Rename a profile. |
| `export` | Export a profile to a tar.gz archive. |
| `import` | Import a profile from a tar.gz archive. |

## `aideus profile list`

```bash
aideus profile list
```

Lists all profiles. The currently active profile is marked with `*`.

**Example:**

```bash
$ aideus profile list
  default
* work
  dev
  personal
```

No options.

## `aideus profile use`

```bash
aideus profile use <name>
```

Sets `<name>` as the active profile. All subsequent `aideus` commands (without `-p`) will use this profile.

| Argument | Description |
|----------|-------------|
| `<name>` | Profile name to activate. Use `default` to return to the base profile. |

**Example:**

```bash
aideus profile use work
aideus profile use default
```

## `aideus profile create`

```bash
aideus profile create <name> [options]
```

Creates a new profile.

| Argument / Option | Description |
|-------------------|-------------|
| `<name>` | Name for the new profile. Must be a valid directory name (alphanumeric, hyphens, underscores). |
| `--clone` | Copy `config.yaml`, `.env`, and `SOUL.md` from the current profile. |
| `--clone-all` | Copy everything (config, memories, skills, sessions, state) from the current profile. |
| `--clone-from <profile>` | Clone from a specific profile instead of the current one. Used with `--clone` or `--clone-all`. |
| `--no-alias` | Skip wrapper script creation. |

Creating a profile does **not** make that profile directory the default project/workspace directory for terminal commands. If you want a profile to start in a specific project, set `terminal.cwd` in that profile's `config.yaml`.

**Examples:**

```bash
# Blank profile — needs full setup
aideus profile create mybot

# Clone config only from current profile
aideus profile create work --clone

# Clone everything from current profile
aideus profile create backup --clone-all

# Clone config from a specific profile
aideus profile create work2 --clone --clone-from work
```

## `aideus profile delete`

```bash
aideus profile delete <name> [options]
```

Deletes a profile and removes its shell alias.

| Argument / Option | Description |
|-------------------|-------------|
| `<name>` | Profile to delete. |
| `--yes`, `-y` | Skip confirmation prompt. |

**Example:**

```bash
aideus profile delete mybot
aideus profile delete mybot --yes
```

:::warning
This permanently deletes the profile's entire directory including all config, memories, sessions, and skills. Cannot delete the currently active profile.
:::

## `aideus profile show`

```bash
aideus profile show <name>
```

Displays details about a profile including its home directory, configured model, gateway status, skills count, and configuration file status.

This shows the profile's Aideus home directory, not the terminal working directory. Terminal commands start from `terminal.cwd` (or the launch directory on the local backend when `cwd: "."`).

| Argument | Description |
|----------|-------------|
| `<name>` | Profile to inspect. |

**Example:**

```bash
$ aideus profile show work
Profile: work
Path:    ~/.aideus/profiles/work
Model:   anthropic/claude-sonnet-4 (anthropic)
Gateway: stopped
Skills:  12
.env:    exists
SOUL.md: exists
Alias:   ~/.local/bin/work
```

## `aideus profile alias`

```bash
aideus profile alias <name> [options]
```

Regenerates the shell alias script at `~/.local/bin/<name>`. Useful if the alias was accidentally deleted or if you need to update it after moving your Aideus installation.

| Argument / Option | Description |
|-------------------|-------------|
| `<name>` | Profile to create/update the alias for. |
| `--remove` | Remove the wrapper script instead of creating it. |
| `--name <alias>` | Custom alias name (default: profile name). |

**Example:**

```bash
aideus profile alias work
# Creates/updates ~/.local/bin/work

aideus profile alias work --name mywork
# Creates ~/.local/bin/mywork

aideus profile alias work --remove
# Removes the wrapper script
```

## `aideus profile rename`

```bash
aideus profile rename <old-name> <new-name>
```

Renames a profile. Updates the directory and shell alias.

| Argument | Description |
|----------|-------------|
| `<old-name>` | Current profile name. |
| `<new-name>` | New profile name. |

**Example:**

```bash
aideus profile rename mybot assistant
# ~/.aideus/profiles/mybot → ~/.aideus/profiles/assistant
# ~/.local/bin/mybot → ~/.local/bin/assistant
```

## `aideus profile export`

```bash
aideus profile export <name> [options]
```

Exports a profile as a compressed tar.gz archive.

| Argument / Option | Description |
|-------------------|-------------|
| `<name>` | Profile to export. |
| `-o`, `--output <path>` | Output file path (default: `<name>.tar.gz`). |

**Example:**

```bash
aideus profile export work
# Creates work.tar.gz in the current directory

aideus profile export work -o ./work-2026-03-29.tar.gz
```

## `aideus profile import`

```bash
aideus profile import <archive> [options]
```

Imports a profile from a tar.gz archive.

| Argument / Option | Description |
|-------------------|-------------|
| `<archive>` | Path to the tar.gz archive to import. |
| `--name <name>` | Name for the imported profile (default: inferred from archive). |

**Example:**

```bash
aideus profile import ./work-2026-03-29.tar.gz
# Infers profile name from the archive

aideus profile import ./work-2026-03-29.tar.gz --name work-restored
```

## `aideus -p` / `aideus --profile`

```bash
aideus -p <name> <command> [options]
aideus --profile <name> <command> [options]
```

Global flag to run any Aideus command under a specific profile without changing the sticky default. This overrides the active profile for the duration of the command.

| Option | Description |
|--------|-------------|
| `-p <name>`, `--profile <name>` | Profile to use for this command. |

**Examples:**

```bash
aideus -p work chat -q "Check the server status"
aideus --profile dev gateway start
aideus -p personal skills list
aideus -p work config edit
```

## `aideus completion`

```bash
aideus completion <shell>
```

Generates shell completion scripts. Includes completions for profile names and profile subcommands.

| Argument | Description |
|----------|-------------|
| `<shell>` | Shell to generate completions for: `bash` or `zsh`. |

**Examples:**

```bash
# Install completions
aideus completion bash >> ~/.bashrc
aideus completion zsh >> ~/.zshrc

# Reload shell
source ~/.bashrc
```

After installation, tab completion works for:
- `aideus profile <TAB>` — subcommands (list, use, create, etc.)
- `aideus profile use <TAB>` — profile names
- `aideus -p <TAB>` — profile names

## See also

- [Profiles User Guide](../user-guide/profiles.md)
- [CLI Commands Reference](./cli-commands.md)
- [FAQ — Profiles section](./faq.md#profiles)
