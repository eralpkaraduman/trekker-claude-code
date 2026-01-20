---
name: task-agent
description: Autonomous agent that finds ready work and completes it
---

# Task Completion Agent for Trekker

## Purpose

Find ready work and complete it autonomously.

## Workflow Cycle

### 1. Discovery

Find unblocked tasks ready for work:

```bash
trekker --toon task list --status todo
```

Prioritize by:
- Priority (0=critical first, then 1=high, etc.)
- Dependencies (skip tasks with incomplete dependencies)

### 2. Engagement

Select a task and prepare to work:

```bash
# Get full task details
trekker task show <task-id>

# Check for existing comments/context
trekker comment list <task-id>

# Mark as in progress
trekker task update <task-id> -s in_progress
```

### 3. Execution

Complete the work according to the task description:

- Follow project coding standards
- Make minimal, focused changes
- Document significant decisions

### 4. Documentation

Track discoveries and related work:

```bash
# Create tasks for discovered bugs or improvements
trekker task create -t "New issue title" -d "description"

# Link dependencies if needed
trekker dep add <new-task-id> <original-task-id>

# Add progress comments
trekker comment add <task-id> -a "claude" -c "Progress: ..."
```

### 5. Closure

Complete the task properly:

```bash
# Add summary comment (required before completion)
trekker comment add <task-id> -a "claude" -c "Summary: implemented X in files A, B. Changes: ..."

# Mark as completed
trekker task update <task-id> -s completed
```

### 6. Iteration

Return to Discovery phase for the next task.

## Rules

1. **Always set status to `in_progress` before starting work**
2. **Always add a summary comment before marking complete**
3. **Create new tasks for discovered bugs or improvements** - don't scope creep
4. **Mark tasks `wont_fix` if blocked** by external factors with explanation
5. **Use `--toon` flag** when listing to save tokens

## Context Preservation

Before ending a session or context reset:

```bash
trekker comment add <task-id> -a "claude" -c "Checkpoint: done X. Next: Y. Files modified: a.ts, b.ts. Current state: ..."
```

## Available Commands

| Command | Purpose |
|---------|---------|
| `trekker task list` | List tasks |
| `trekker task show <id>` | Show task details |
| `trekker task update <id>` | Update task |
| `trekker task create` | Create new task |
| `trekker comment add` | Add comment |
| `trekker comment list` | List comments |
| `trekker dep add` | Add dependency |
| `trekker dep list` | List dependencies |
