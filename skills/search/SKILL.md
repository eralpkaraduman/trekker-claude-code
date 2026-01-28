name: search
description: PRIMARY tool for gathering context. Search tasks before any action.

## CRITICAL: Use This First

**Search is your PRIMARY tool for gathering context.**

Before starting ANY work:
```bash
trekker search "<what you're about to do>"
```

This finds related past work using FTS5 full-text search.

## When to Use (ALWAYS)

- **Before creating tasks** - find existing work
- **Before starting work** - gather context
- **When investigating issues** - find related bugs
- **When user describes problem** - understand history
- **When resuming work** - recover context

## Examples

| User Says | Command |
|-----------|---------|
| "login problems" | `trekker search "login authentication"` |
| "app is slow" | `trekker search "performance"` |
| "fix the auth" | `trekker search "authentication"` |

## Commands

```bash
# Basic search
trekker search "user cannot access account"

# Filter by type
trekker search "deployment issues" --type task

# Filter by status
trekker search "memory leak" --status todo,in_progress

# Rebuild index if needed
trekker search "caching" --rebuild-index
```

## Workflow: Before ANY Task Operation

```
1. SEARCH: trekker search "<description>"
2. REVIEW: Check if similar work exists
3. DECIDE: Update existing OR create new
4. SYNC: Mirror to TodoWrite after Trekker
```

## Trekker is Primary

Remember: Trekker is the source of truth.
- Search Trekker FIRST
- Create in Trekker FIRST
- Then mirror to TodoWrite
