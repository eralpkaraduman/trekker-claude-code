---
name: trekker
description: Persistent task memory for AI agents across sessions
version: 0.1.2
---

# Trekker - Issue Tracker for AI Agents

Trekker provides persistent task memory across sessions. Unlike TodoWrite which is conversation-scoped, trekker stores tasks in a SQLite database that survives context resets.

## Quick Reference

**Run `trekker quickstart` for the complete command reference and workflow guide.**

---

## When to Use Trekker vs TodoWrite

| Aspect | Trekker | TodoWrite |
|--------|---------|-----------|
| Scope | Multi-session | Single-session |
| Persistence | SQLite database | Conversation-scoped |
| Best for | Complex projects, dependencies | Linear checklists |

**Decision rule**: "Will I need this context tomorrow?" If yes, use Trekker.

---

## Strict Usage Rules

### MUST DO

1. **Set status `in_progress` before starting work** on any task
2. **Add summary comment before marking `completed`**
3. **Search before creating** - avoid duplicates
4. **One task `in_progress` at a time** - complete current work first
5. **Use `--toon` flag** for programmatic output to save tokens
6. **Reference tasks by ID** (e.g., TREK-1, EPIC-1) in discussions
7. **Add checkpoint comment before context reset** with: what's done, what's next, files modified

### MUST NOT DO

1. **Never invent task IDs** - only use IDs returned by trekker commands
2. **Never overwrite without confirmation** - always show current state before update
3. **Never mark complete without summary** - future sessions depend on this context
4. **Never skip dependency checks** - verify blockers are resolved first
5. **Never assume task exists** - verify with `trekker task show <id>` first
6. **Never delete without explicit user request** - prefer `archived` status

### When to Create Issues

**CREATE** when:
- Work spans multiple sessions
- Task has dependencies or subtasks
- User explicitly requests tracking
- Bug or feature needs documented investigation
- Work needs to be handed off to another session

**DO NOT CREATE** when:
- Task is trivial (< 1 minute)
- User explicitly declines
- Just exploring or brainstorming
- One-off question or clarification

---

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

---

## Key Commands

| Command | Purpose |
|---------|---------|
| `trekker task create -t "Title"` | Create task |
| `trekker task list [--status X]` | List tasks |
| `trekker task show <id>` | Show details |
| `trekker task update <id> -s <status>` | Update status |
| `trekker comment add <id> -a "claude" -c "..."` | Add comment |
| `trekker dep add <id> <depends-on>` | Add dependency |
| `trekker search "<query>"` | Full-text search |
| `trekker history --entity <id>` | View change history |

**IMPORTANT**: Skill names (e.g., `/start`, `/blocked`) are NOT CLI commands. Always use `trekker task update <id> -s <status>` to change status.

**Need more details?** Run `trekker quickstart` for full command syntax and examples.

---

## Status Values

Tasks: `todo`, `in_progress`, `completed`, `wont_fix`, `archived`

## Priority Scale

0=critical, 1=high, 2=medium (default), 3=low, 4=backlog, 5=someday

---

## Naming Conventions

### Task Titles
- Start with verb: "Implement", "Fix", "Add", "Update", "Remove"
- Be specific: "Fix login failure with special characters" not "Fix login"
- Include scope: "Add validation to user registration form"

### Comments
- Progress: "Progress: completed X, working on Y"
- Summary: "Summary: implemented X in files A, B. Changes: ..."
- Checkpoint: "Checkpoint: done X. Next: Y. Files: a.ts, b.ts"
- Blocker: "Blocked: waiting on external API documentation"

---

## Multi-Instance Safety

Trekker uses SQLite with Write-Ahead Logging (WAL) for concurrent access.

**Best practices:**
- Always fetch latest state before updates: `trekker task show <id>`
- Use comments for coordination between instances
- Prefer additive operations (comments) over destructive ones (delete)
- If conflict detected, refresh and retry
