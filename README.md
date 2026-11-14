# iomatrix CLI

Terminal companion for [iomatrix](https://apps.apple.com/app/iomatrix) — Eisenhower Matrix task manager for macOS/iOS.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/cr8rcho/iomatrix-cli/main/install.sh | sh
```

## Requirements

- macOS 15+
- iomatrix macOS app **1.16.0 or later**, installed and launched at least once
- The CLI and the app must be on matching data versions. If the CLI says the app's data is older or newer, update whichever one it names — it changes nothing until they match.

## Usage

```bash
iomatrix                              # Show summary
iomatrix add "Task title" -q 1        # Add to Q1 (Do)
iomatrix list                         # List tasks
iomatrix list -q 2                    # List Q2 only
iomatrix done <id>                    # Mark complete
iomatrix move <id> -q 3              # Move to Q3
iomatrix edit <id> -t "New title"    # Edit task
iomatrix edit <id> -d "2026-04-15"   # Due date (add " 14:30" for a time)
iomatrix list -t                      # Subtask trees
iomatrix add "Subtask" --under <id>   # Add as a subtask (Pro)
iomatrix delete <id>                  # Delete task
iomatrix link <id> -a "https://..."  # Add link
```

## Quadrants

| # | Name | Description |
|---|------|-------------|
| 1 | Do | Urgent & Important |
| 2 | Schedule | Important & Not Urgent |
| 3 | Delegate | Urgent & Not Important |
| 4 | Delete | Not Urgent & Not Important |

## Agent Skill (Claude Code / Codex CLI)

An [Agent Skill](skills/iomatrix/SKILL.md) is included so coding agents can manage your matrix for you — ask things like "what tasks are left?" or "add a task to my matrix". SKILL.md is an open format, so the same file works in Claude Code, Codex CLI, and other compatible agents.

After installing the CLI, copy the skill into your agent's skills directory:

```bash
# Claude Code
mkdir -p ~/.claude/skills/iomatrix
curl -fsSL https://raw.githubusercontent.com/cr8rcho/iomatrix-cli/main/skills/iomatrix/SKILL.md \
  -o ~/.claude/skills/iomatrix/SKILL.md

# Codex CLI
mkdir -p ~/.codex/skills/iomatrix
curl -fsSL https://raw.githubusercontent.com/cr8rcho/iomatrix-cli/main/skills/iomatrix/SKILL.md \
  -o ~/.codex/skills/iomatrix/SKILL.md
```

## Uninstall

```bash
rm /usr/local/bin/iomatrix
```
