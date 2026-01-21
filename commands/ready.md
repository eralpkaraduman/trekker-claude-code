---
name: trekker:ready
description: Find tasks ready to work on
---

Find unblocked tasks that are ready to be worked on, with full context from recent history.

**IMPORTANT**: `/trekker:ready` is a skill (invoke via Skill tool), NOT a bash command. Use `trekker` CLI as shown below.

## Execution

### Step 1: Context Recovery (Required)

Before picking new work, understand what's been happening:

```bash
# Check for any in-progress work first
trekker --toon task list --status in_progress

# Review recent changes for context
trekker history --limit 10
```

**Why this matters:**
- Avoid picking up work that's already started
- Understand recent decisions and completions
- Recall context from previous sessions

### Step 2: Find Ready Work

```bash
# Ready tasks by priority
trekker list --type task --status todo --sort priority:asc

# Or just tasks
trekker --toon task list --status todo
```

### Step 3: Get Context Before Starting

Before recommending a task, check its history and comments:

```bash
# Task details
trekker task show <task-id>

# Change history for this task
trekker history --entity <task-id>

# Comments for context
trekker comment list <task-id>
```

## Prioritization

Present tasks sorted by priority (0=critical first).

## After Listing

Ask if the user wants to start working on one of the ready tasks.
If yes, use `/trekker:start <task-id>` workflow.
