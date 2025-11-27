# Draft Idea from GitHub Issue

Your task is to interactively help the user select a promising GitHub issue and convert it into a **draft** project structure (like wishfire).

**Goal**: Create a "good first pass" structure that's ready for iteration, not a perfect implementation plan.

## Process

### 1. Discover Issues

Fetch and present open issues interactively:

```bash
gh issue list --repo aliwatters/ideas --json number,title,body,labels,comments --limit 50
```

Present 2-4 most promising options to the user (use AskUserQuestion tool).

### 2. Analyze Selected Issue

Fetch full issue details:

```bash
gh issue view <number> --repo aliwatters/ideas --json title,body,comments
```

Extract:
- Core problem/pain point
- Target users
- Proposed solution
- Key features

**Ask clarifying questions** if the issue is vague:
- Who is the target user?
- What's the main problem?
- What are 3-5 key features?

### 3. Create Draft Structure

Build directory structure:

```
project-name/
├── README.md              # Draft overview
├── feature-1/
│   └── README.md
├── feature-2/
│   ├── README.md
│   └── spec.feature      # ONE example spec
└── feature-3/
    └── README.md
```

**Start with 2-4 core features**, create ONE Gherkin spec for the most critical feature.

### 4. Draft Main README.md

Use TEMPLATES/PROJECT_README.md as reference, keep it lighter:

**Include (draft quality)**:
- Problem Statement (1-2 paragraphs)
- Solution overview (bullets fine)
- Key Features (3-5 items)
- Quick competitive research (2-3 alternatives via WebSearch)
- Potential tech stack (reasonable defaults)
- Feature breakdown

**Skip**: Detailed effort analysis, comprehensive research, architecture decisions

### 5. Draft Feature READMEs

For each feature, create lightweight README.md:
- One-line description
- User story format
- 2-3 key scenarios
- Keep under 50 lines

### 6. Create ONE Gherkin Spec

Pick most important feature, create spec.feature:
- Feature description with user story
- 2-3 scenarios (happy path + 1 error case)
- Reference TEMPLATES/GHERKIN_EXAMPLE.feature

### 7. Update Original Issue

```bash
gh issue comment <number> --repo aliwatters/ideas --body "..."
```

Include:
- Link to project directory
- Structure summary
- Features drafted
- Next steps/questions
- Invitation for feedback

### 8. Offer Refinement

**Ask user**:
- Expand any specific feature?
- Add more Gherkin specs?
- Missing features?
- More research needed?

## Success Criteria

- User selected issue interactively
- Project directory created
- Main README covers problem/solution/features
- 2-4 feature directories with READMEs
- At least 1 Gherkin spec
- Original issue updated
- Quality is "good first draft"

## Key Principles

- **Interactive**: Ask questions, don't assume
- **Iterative**: Draft first, refine later
- **Pragmatic**: Quick research, reasonable choices
- **Fast**: ~15-20 min for initial structure
- **Opinionated**: Make choices, document assumptions

## Tools

- `gh issue list/view/comment`
- `WebSearch` for competitive research
- `AskUserQuestion` for interaction
- File tools (Write, Read)

## See Also

**Workflow**: [DRAFT_IDEA_FROM_ISSUE.md](~/git/ideas/workflows/DRAFT_IDEA_FROM_ISSUE.md) - Detailed procedural guide
