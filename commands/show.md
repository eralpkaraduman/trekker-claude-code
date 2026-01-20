---
name: show
description: Show details of a specific task
---

Show detailed information about a task.

## Arguments

- `$1`: Task ID (e.g., TREK-1) - required

If no task ID provided, ask the user which task to show.

## Execution

```bash
trekker task show <task-id>
```

## Also Show

After showing the task, also display:
- Comments: `trekker comment list <task-id>`
- Dependencies: `trekker dep list <task-id>`
