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
iomatrix list -t                  # subtask trees (roots, then indented subtasks)

iomatrix add "title" -q 2 -n "note" -w "Work" -l "https://a.com"   # -l repeatable
iomatrix add "title" --under <id-prefix>   # subtask (Pro); quadrant/workspace default to the parent's

iomatrix done <id-prefix>         # mark complete
iomatrix move <id-prefix> -q 2    # change quadrant
iomatrix move <id-prefix> --under <id-prefix>   # make it a subtask (Pro; its own subtasks move too)
iomatrix move <id-prefix> --root  # detach from its parent
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
- **Subtasks**: a parent shows `[done/total]` after its id and a subtask shows ` ↳`. Use `list -t` to see the tree. A task has at most one parent; `move --under` refuses the task itself or one of its own subtasks. Belonging (subtask) is separate from order — completing a parent never completes its subtasks, and finishing all subtasks never completes the parent.
- **`--under` needs iomatrix Pro** (both `add` and `move`). The CLI reads the Pro status the Mac app leaves behind; if it isn't Pro it changes nothing, prints a notice to stderr and exits 1. "… is part of iomatrix Pro" → tell the user it's a Pro feature they can get in the app (Settings › General › Pro (Lifetime)). "… couldn't confirm Pro on this Mac" → ask the user to open the iomatrix Mac app once (latest version) and retry; if they bought Pro on iPhone, the Mac app has to run before the CLI knows. Don't try to work around it (e.g. by editing files). `list -t`, `move --root`, and everything else work without Pro.
- `done` on an already-completed task is a no-op (keeps the original completion time).
- **Due dates**: `edit -d "2026-04-15"` sets a day with no time; `-d "2026-04-15 14:30"` sets a time. `list` prints the time only for a due date that has one.
- **Version mismatch**: if a command prints "this iomatrix CLI is older than the iomatrix app's data", the CLI must be updated (re-run the install script); if it prints "the iomatrix app's data is older than this CLI", ask the user to update the iomatrix Mac app and open it once. Either way the CLI changed nothing and exits 1 — don't retry or work around it.
- **`delete` is permanent** and `--matching` deletes every title match — show the matches and confirm with the user before bulk deletes.

## Routines (repeating tasks)

Tasks marked `↻` in `list` are occurrences of a routine (a repeating-task template managed in the app).

- `done` on a routine occurrence schedules the next occurrence automatically and prints its due date. Completing before the due date prints a `⚠ Completed early` notice — mention it to the user.
- `delete` on an incomplete routine occurrence does **not** delete it — it skips this occurrence (no completion recorded) and schedules the next one. `delete --matching` leaves routine occurrences untouched.
- Routines themselves (create / edit / pause / stop) are managed only in the app's Routine page, not the CLI — direct the user there.
