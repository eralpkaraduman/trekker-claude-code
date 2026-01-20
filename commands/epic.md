---
name: epic
description: Manage epics
---

Create, list, or show epics.

## Subcommands

Ask the user what they want to do:
- **create**: Create a new epic
- **list**: List all epics
- **show**: Show epic details with its tasks

## Create Epic

```bash
trekker epic create -t "<title>" [-d "<description>"] [-p <priority>]
```

## List Epics

```bash
trekker --toon epic list [--status <status>]
```

## Show Epic

```bash
trekker epic show <epic-id>
trekker --toon task list --epic <epic-id>
```
