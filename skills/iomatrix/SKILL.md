---
name: iomatrix
description: Manage Eisenhower Matrix tasks via the iomatrix CLI. Use when the user wants to view, add, complete, move, edit, delete, or link tasks in their iomatrix app — e.g. "what tasks are left", "add a task to my matrix", "mark X as done", "show my backlog". Requires the iomatrix macOS app and the iomatrix CLI installed.
---

# iomatrix CLI

`iomatrix` manages tasks in the iomatrix Eisenhower Matrix app. It reads and writes the app's local store directly, so changes appear in the app immediately and sync to the user's other devices via iCloud the next time the app runs.

## Prerequisites

- `iomatrix` must be on PATH. If not found, tell the user to install it from https://github.com/cr8rcho/iomatrix-cli — do not guess at binary paths.
- The iomatrix macOS app must have been launched at least once (the CLI refuses to create a store on its own).

## Quadrants

`-q` takes the user-facing number: **1 = Do** (urgent + important), **2 = Schedule** (important), **3 = Delegate** (urgent), **4 = Delete** (neither).

## Commands

```bash
iomatrix                          # summary per quadrant (default command)
iomatrix summary -w "Work"        # summary, optionally per workspace

iomatrix list                     # incomplete active tasks
iomatrix list -a                  # include completed
iomatrix list -b                  # backlog tasks
iomatrix list -q 1 -w "Work"      # filter by quadrant / workspace

iomatrix add "title" -q 2 -n "note" -w "Work" -l "https://a.com"   # -l repeatable

iomatrix done <id-prefix>         # mark complete
iomatrix move <id-prefix> -q 2    # change quadrant
iomatrix edit <id-prefix> -t "new title" -n "note" -d "2026-04-15" # or "YYYY-MM-DD HH:mm"
iomatrix edit <id-prefix> --clear-due
iomatrix edit <id-prefix> -w ""   # clear workspace

iomatrix link <id-prefix> -a "https://a.com"   # add link
iomatrix link <id-prefix> -l      # list links
iomatrix link <id-prefix> -r 1    # remove link by index

iomatrix delete <id-prefix>
iomatrix delete "keyword" --matching   # deletes ALL title matches
```

## Workflow notes

- **Task IDs**: `list` prints an 8-char short id like `[a1b2c3d4]`. Any unique prefix works; ambiguous prefixes are rejected with candidates listed.
- **Workspace in output**: `list` shows a task's workspace in parentheses after the id, e.g. `[a1b2c3d4] (💼 Work)`; tasks in the default workspace have no parenthesis. Workspace names include their emoji — pass the full name to `-w`.
- **"What's left?"** = `iomatrix list` (active) plus `iomatrix list -b` (backlog) — backlog is hidden by default.
- **Workspaces** (`-w`) must already exist in the app; `add`/`edit` reject unknown names and print the available ones. Create workspaces in the app, not the CLI.
- `done` on an already-completed task is a no-op (keeps the original completion time).
- **`delete` is permanent** and `--matching` deletes every title match — show the matches and confirm with the user before bulk deletes.
