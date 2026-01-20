---
name: trekker
description: Persistent task memory for AI agents across sessions
version: 0.1.0
---

# Trekker - Issue Tracker for AI Agents

Trekker provides persistent task memory across sessions. Unlike TodoWrite which is conversation-scoped, trekker stores tasks in a SQLite database that survives context resets.

## When to Use Trekker vs TodoWrite

| Aspect | Trekker | TodoWrite |
|--------|---------|-----------|
| Scope | Multi-session | Single-session |
| Persistence | SQLite database | Conversation-scoped |
| Best for | Complex projects, dependencies | Linear checklists |

**Decision rule**: "Will I need this context tomorrow?" If yes, use Trekker.

## Essential Workflow

### Session Start

```bash
# Check current work
trekker --toon task list --status in_progress

# Get context from comments
trekker comment list <task-id>
```

### Working on Tasks

```bash
# Start a task
trekker task update <task-id> -s in_progress

# Document progress
trekker comment add <task-id> -a "claude" -c "Progress: ..."

# Complete with summary
trekker comment add <task-id> -a "claude" -c "Summary: ..."
trekker task update <task-id> -s completed
```

### Before Context Reset

```bash
trekker comment add <task-id> -a "claude" -c "Checkpoint: done X. Next: Y. Files: a.ts, b.ts"
```

## Key Commands

| Command | Purpose |
|---------|---------|
| `trekker task create -t "Title"` | Create task |
| `trekker task list [--status X]` | List tasks |
| `trekker task show <id>` | Show details |
| `trekker task update <id> -s <status>` | Update status |
| `trekker comment add <id> -a "claude" -c "..."` | Add comment |
| `trekker dep add <id> <depends-on>` | Add dependency |

## Status Values

Tasks: `todo`, `in_progress`, `completed`, `wont_fix`, `archived`

## Priority Scale

0=critical, 1=high, 2=medium (default), 3=low, 4=backlog, 5=someday
