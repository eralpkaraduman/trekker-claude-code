#!/bin/bash
# Session start hook: Load trekker context and restore state for new sessions
# This runs at the start of each Claude Code session to provide context

# Check if trekker is initialized
if [ ! -d ".trekker" ]; then
    echo "# Trekker (not initialized)"
    echo ""
    echo "Run \`trekker init\` to initialize issue tracking in this project."
    exit 0
fi

echo "# Trekker Session Context"
echo ""

# ============================================================================
# SECTION 1: State Summary (Quick Overview)
# ============================================================================
TODO=$(trekker --json task list --status todo 2>/dev/null | grep -o '"id"' | wc -l | tr -d ' ')
IN_PROG=$(trekker --json task list --status in_progress 2>/dev/null | grep -o '"id"' | wc -l | tr -d ' ')
EPIC_COUNT=$(trekker --json epic list 2>/dev/null | grep -o '"id"' | wc -l | tr -d ' ')

echo "**State**: $IN_PROG in-progress | $TODO todo | $EPIC_COUNT epics"
echo ""

# ============================================================================
# SECTION 2: Resume In-Progress Work
# ============================================================================
IN_PROGRESS=$(trekker --json task list --status in_progress 2>/dev/null)
IN_PROGRESS_COUNT=$(echo "$IN_PROGRESS" | grep -o '"id"' | wc -l | tr -d ' ')

if [ "$IN_PROGRESS_COUNT" -gt 0 ]; then
    echo "## Resume In-Progress Work"
    echo ""
    trekker --toon task list --status in_progress 2>/dev/null
    echo ""

    # Show context for each in-progress task
    echo "### Task Context"
    echo ""

    for task_id in $(echo "$IN_PROGRESS" | grep -o '"id":"[^"]*"' | cut -d'"' -f4); do
        echo "#### $task_id"
        echo ""

        # Get task title and description
        TASK_JSON=$(trekker --json task show "$task_id" 2>/dev/null)
        TASK_TITLE=$(echo "$TASK_JSON" | grep -o '"title":"[^"]*"' | cut -d'"' -f4 | head -1)
        TASK_DESC=$(echo "$TASK_JSON" | grep -o '"description":"[^"]*"' | cut -d'"' -f4 | head -1)

        if [ -n "$TASK_TITLE" ]; then
            echo "**Title**: $TASK_TITLE"
        fi

        if [ -n "$TASK_DESC" ] && [ "$TASK_DESC" != "null" ]; then
            echo "**Description**: $TASK_DESC"
        fi
        echo ""

        # Get last checkpoint or recent comments
        echo "**Recent Comments (last 3):**"
        COMMENTS=$(trekker --toon comment list "$task_id" 2>/dev/null | tail -6)
        if [ -n "$COMMENTS" ]; then
            echo "$COMMENTS"
        else
            echo "No comments yet."
        fi
        echo ""

        # Check for dependencies
        DEPS=$(trekker --json dep list "$task_id" 2>/dev/null | grep -o '"id"' | wc -l | tr -d ' ')
        if [ "$DEPS" -gt 0 ]; then
            echo "**Has $DEPS dependencies** - run \`trekker dep list $task_id\` to view"
            echo ""
        fi
    done

    echo "### Next Steps"
    echo ""
    echo "1. Review the context above"
    echo "2. If resuming from compaction, check recent checkpoint comments for state"
    echo "3. Continue working on the task"
    echo "4. Add progress/checkpoint comments as needed"
    echo ""

else
    # ============================================================================
    # SECTION 3: No Work In Progress - Show Ready Tasks
    # ============================================================================
    echo "## No Work In Progress"
    echo ""

    if [ "$TODO" -gt 0 ]; then
        echo "### Ready Tasks (sorted by priority)"
        echo ""
        trekker --toon task list --status todo 2>/dev/null | head -12
        echo ""

        echo "### To Start Working"
        echo ""
        echo "1. Pick a task: \`trekker task show <id>\`"
        echo "2. Check dependencies: \`trekker dep list <id>\`"
        echo "3. Start work: \`trekker task update <id> -s in_progress\`"
        echo ""
    else
        echo "No pending tasks."
        echo ""
        echo "### Create a Task"
        echo ""
        echo "\`\`\`bash"
        echo "trekker task create -t \"Task title\" [-d \"description\"] [-p 0-5] [-e EPIC-1]"
        echo "\`\`\`"
        echo ""
    fi
fi

# ============================================================================
# SECTION 4: Recent Activity (for context awareness)
# ============================================================================
echo "## Recent Activity (last 3)"
echo ""
trekker --toon history --limit 3 2>/dev/null || echo "No recent history."
echo ""

# ============================================================================
# SECTION 5: Workflow Reminder
# ============================================================================
echo "---"
echo ""
echo "**Workflow**: \`in_progress\` -> work -> summary comment -> \`completed\`"
echo "**Full guide**: \`trekker quickstart\` | **Search**: \`trekker search \"<query>\"\`"
echo ""
echo "Run \`trekker quickstart\` anytime for complete command reference and examples."
