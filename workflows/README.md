# Workflows Directory

This directory contains detailed workflow documentation for idea development processes.

## Available Workflows

### Idea Development

- **[DRAFT_IDEA_FROM_ISSUE.md](DRAFT_IDEA_FROM_ISSUE.md)** - Convert GitHub issue to draft project structure
  - **Prompt**: [draft-idea-from-issue.md](~/git/ideas/prompts/draft-idea-from-issue.md)
  - **Purpose**: Interactive conversion of issues into wishfire-style projects
  - **Duration**: 15-30 minutes
  - **Output**: Draft project with README, features, and example Gherkin spec
  - **Quality**: "Good first pass" not "perfect"

## Workflow Structure

Each workflow includes:

1. **Overview** - Purpose, duration, prerequisites
2. **Phases** - Organized step-by-step process
3. **Commands** - Exact bash/gh commands to run
4. **Verification** - How to check each step succeeded
5. **Success criteria** - What "done" looks like
6. **Principles** - Key guidelines to follow
7. **Common pitfalls** - What to avoid
8. **Tools required** - Dependencies and utilities

## Workflow Philosophy

### Quality Over Perfection

- **Draft first, refine later** - Get structure in place quickly
- **Interactive** - Collaborate with user, don't assume
- **Iterative** - Offer refinement after initial draft
- **Pragmatic** - Make reasonable choices, document assumptions

### Speed and Focus

- **Time-boxed** - Most workflows target 15-30 min
- **Focused scope** - Start with 2-4 core features, not everything
- **Quick research** - Use WebSearch for basics, don't over-research
- **Template-aware** - Reference templates but don't require perfection

## Relationship to Prompts

- **Workflows**: Comprehensive guides (1000-3000 lines) with full procedural details
- **Prompts**: Quick reference (~100 lines) for starting the workflow

Start with the prompt, reference the workflow for details.

## Creating New Workflows

When creating new workflows:

1. **Clear phases** - Break into logical sections
2. **Exact commands** - Provide copy-pasteable bash/gh commands
3. **Verification steps** - How to check each phase worked
4. **Examples** - Show expected outputs
5. **Error handling** - Common issues and solutions
6. **Principles section** - Key guidelines to follow
7. **Avoid echo statements** - Provide commands + verification, not status output
8. **Success criteria** - Clear checklist of completion requirements

## Pattern: Interactive Workflows

Many workflows in this repository are **interactive**:

- Use `AskUserQuestion` tool for selections
- Offer multiple options at decision points
- Allow refinement after initial draft
- Respect user's time - offer "looks good" option

## Example Usage

### Converting an Issue to Project Structure

```bash
# 1. View the prompt for quick reference
cat ~/git/ideas/prompts/draft-idea-from-issue.md

# 2. Run the workflow with Claude Code
# Load the prompt in Claude Code session

# 3. Follow interactive steps:
#    - Select issue from presented options
#    - Answer clarifying questions
#    - Review generated structure
#    - Choose refinement options

# 4. Result: Draft project ready for iteration
```

## Related

- **Prompts**: [../prompts/](../prompts/) - Quick reference guides
- **Templates**: [../TEMPLATES/](../TEMPLATES/) - Project structure templates
- **Examples**: [../wishfire/](../wishfire/) - Reference implementation
