---
name: trekker:start
description: Start working on a task
---

Begin working on a task by setting its status to in_progress.

**IMPORTANT**: `/trekker:start` is a skill (invoke via Skill tool), NOT a bash command. There is no `trekker start` CLI command. Use `trekker task update` as shown below.

## Arguments

- `$1`: Task ID (e.g., TREK-1) - optional

If no task ID provided:
1. Show current in_progress tasks
2. Show ready tasks (todo status)
3. Ask which task to start

## Execution

### Step 1: Gather Context (Required)

Before starting, understand the task's history:

```bash
# Show task details
trekker task show <task-id>

# View change history for this task
trekker history --entity <task-id>

# Get comments for context
trekker comment list <task-id>
```

**Why this matters:**
- Understand previous work on this task
- See if it was started/stopped before
- Recall decisions and blockers from past sessions

### Step 2: Start the Task

```bash
# Set status to in_progress
trekker task update <task-id> -s in_progress
```

## After Starting

Display a summary including:
- Task title and description
- Key points from history/comments
- Any dependencies or related tasks
