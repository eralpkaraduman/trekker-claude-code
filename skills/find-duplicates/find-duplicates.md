name: find-duplicates
description: MANDATORY before creating any task. Use search to detect duplicates and prevent redundant work.

## CRITICAL: Search Before Creating ANY Task

**You MUST search before creating any task.**

```bash
trekker search "<task description you're about to create>"
```

## When to Use (MANDATORY)

- **BEFORE creating ANY new task** - non-negotiable
- **User reports issue** - check if already tracked
- **Grooming backlog** - find consolidation opportunities
- **Starting new feature** - find related past work

## Commands

```bash
# Search for similar tasks before creating
trekker search "fix authentication bug"

# Search specific type
trekker search "login timeout" --type task

# Search by status
trekker search "performance issue" --status todo,in_progress
```

## MANDATORY Workflow

```
1. SEARCH: trekker search "<what you're about to create>"
2. REVIEW results
3. DECIDE:
   - Found exact match → DO NOT create, update existing task
   - Found related work → Review carefully, may need to link
   - No results → Safe to create new
4. CREATE in Trekker FIRST (if no duplicate)
5. MIRROR to TodoWrite after
```

## Anti-Patterns (DO NOT)

- Creating task without searching first
- Ignoring search results
- Creating in TodoWrite without checking Trekker first

## Trekker is Primary

Always:
1. Check Trekker for duplicates FIRST
2. Create in Trekker FIRST
3. Then mirror to TodoWrite
