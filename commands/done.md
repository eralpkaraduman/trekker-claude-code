---
name: done
description: Complete a task with summary
---

Mark a task as completed with a summary comment.

**NOTE**: This is a skill, not a bash command. There is no `trekker task done` command. Use `trekker task update` as shown below.

## Arguments

- `$1`: Task ID (e.g., TREK-1) - optional

If no task ID provided:
1. Show current in_progress tasks
2. Ask which task to complete

## Flow

1. Ask for a completion summary (what was done, files changed, etc.)
2. Add summary comment
3. Set status to completed
4. Show next ready task

## Execution

```bash
# Add summary comment
trekker comment add <task-id> -a "claude" -c "Summary: <summary>"

# Mark as completed
trekker task update <task-id> -s completed

# Show next ready task
trekker --toon task list --status todo
```
