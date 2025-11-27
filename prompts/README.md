# Prompts Directory

This directory contains AI prompts for idea development workflows.

## Available Prompts

### Idea Development

- **[draft-idea-from-issue.md](draft-idea-from-issue.md)** - Convert GitHub issue into draft project structure
  - Interactive issue selection
  - Creates wishfire-style project directory
  - Generates draft README and feature specs
  - Creates example Gherkin specification
  - Quick/iterative approach (~15-30 min)
  - **Workflow**: [DRAFT_IDEA_FROM_ISSUE.md](~/git/ideas/workflows/DRAFT_IDEA_FROM_ISSUE.md)

## Usage Pattern

1. **Choose a prompt** based on your task
2. **Load into Claude Code** or copy the content
3. **Follow the steps** outlined in the prompt
4. **Reference workflows** for detailed procedural guidance
5. **Use templates** from TEMPLATES/ directory

## Relationship to Workflows

- **Prompts** (~100 lines): Quick reference, step-by-step instructions
- **Workflows** (~1000-3000 lines): Comprehensive procedural guides with detailed steps

Prompts point to workflows for complete details.

## Creating New Prompts

When creating new prompts:

1. **Clear objective** - State purpose upfront
2. **Step-by-step process** - Break down the workflow
3. **Tools required** - List GitHub CLI, web search, etc.
4. **Success criteria** - Define what "done" looks like
5. **Link to workflow** - Reference detailed workflow document
6. **Keep it concise** - Aim for ~100 lines, not exhaustive

## Related

- **Workflows**: [../workflows/](../workflows/) - Detailed procedural guides
- **Templates**: [../TEMPLATES/](../TEMPLATES/) - Project and feature templates
- **Examples**: [../wishfire/](../wishfire/) - Reference implementation
