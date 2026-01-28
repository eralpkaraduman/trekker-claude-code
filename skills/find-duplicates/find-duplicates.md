name: find-duplicates
description: MANDATORY before creating any task. Detects duplicates to prevent redundant work.

## CRITICAL: Run Before Creating ANY Task

**You MUST run `trekker similar` before creating any task.**

```bash
trekker similar "<task description you're about to create>"
```

This prevents duplicate work and consolidates related issues.

## When to Use (MANDATORY)

- **BEFORE creating ANY new task** - non-negotiable
- **User reports issue** - check if already tracked
- **Grooming backlog** - find consolidation opportunities
- **Starting new feature** - find related past work

## Commands

```bash
# Check if description matches existing tasks
trekker similar "fix authentication bug"

# Check similarity to specific task
trekker similar TREK-45

# Lower threshold for broader matches
trekker similar "performance issue" --threshold 0.5
```

## MANDATORY Workflow

```
1. RUN: trekker similar "<what you're about to create>"
2. REVIEW results
3. DECIDE based on score:
   - 90%+ → DO NOT create, update existing task
   - 75-89% → Review carefully, likely related
   - <75% → Safe to create new
4. CREATE in Trekker FIRST (if no duplicate)
5. MIRROR to TodoWrite after
```

## Score Guide

| Score | Action |
|-------|--------|
| 95%+ | **STOP** - Update existing task instead |
| 85-94% | Review - likely the same issue |
| 75-84% | Related - consider linking |
| <75% | Different - safe to create |

## Anti-Patterns (DO NOT)

- Creating task without running `trekker similar` first
- Ignoring high similarity scores
- Creating in TodoWrite without checking Trekker first

## Trekker is Primary

Always:
1. Check Trekker for duplicates FIRST
2. Create in Trekker FIRST
3. Then mirror to TodoWrite
