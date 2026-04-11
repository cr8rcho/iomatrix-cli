# iomatrix CLI

Terminal companion for [iomatrix](https://apps.apple.com/app/iomatrix) — Eisenhower Matrix task manager for macOS/iOS.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/cr8rcho/iomatrix-cli/main/install.sh | sh
```

## Requirements

- macOS 15+
- iomatrix macOS app installed and launched at least once

## Usage

```bash
iomatrix                              # Show summary
iomatrix add "Task title" -q 1        # Add to Q1 (Do)
iomatrix list                         # List tasks
iomatrix list -q 2                    # List Q2 only
iomatrix done <id>                    # Mark complete
iomatrix move <id> -q 3              # Move to Q3
iomatrix edit <id> -t "New title"    # Edit task
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

## Uninstall

```bash
rm /usr/local/bin/iomatrix
```
