# Workflow: Draft Idea from GitHub Issue

## Overview

This workflow guides you through converting a GitHub issue into a draft project structure, following the pattern established by the wishfire project.

**Goal**: Create a "good first pass" structure with reasonable quality, not a fully-fledged implementation plan. Think "ready to iterate" not "production ready."

**Expected Duration**: 15-30 minutes

**Prerequisites**:
- GitHub CLI (`gh`) installed and authenticated
- Write access to aliwatters/ideas repository
- Clean working directory

## Phase 1: Discovery

### Step 1.1: Fetch All Open Issues

Retrieve all open issues from the repository:

```bash
gh issue list --repo aliwatters/ideas --json number,title,body,labels,comments,createdAt --limit 50
```

**Parse and analyze**:
- Filter out meta/organizational issues (unless user specifically wants them)
- Group by status labels if present (brainstorm, researching, specifying, etc.)
- Identify issues that seem ready for structuring (have some detail, not too vague)

### Step 1.2: Present Options to User

Use the `AskUserQuestion` tool to present 2-4 most promising issues:

**Selection criteria for "promising" issues**:
- Has a clear problem statement or description
- Mentions target users or use cases
- Has some feature ideas (even if rough)
- Not already implemented (check for linked PRs or "implemented" status)
- Not too vague (avoid single-line issues without context)

**Format the question**:
- Header: "Select idea"
- Question: "Which idea would you like to develop into a project structure?"
- Options: Present 2-4 issues with:
  - Label: "#<number>: <title>"
  - Description: Brief summary of the problem/idea
- multiSelect: false

**Allow "Other" option** for manual selection if user wants a different issue.

### Step 1.3: Fetch Full Issue Details

Once user selects an issue, fetch complete details:

```bash
gh issue view <number> --repo aliwatters/ideas --json title,body,comments,labels
```

**Extract information**:
- Issue title → project name (convert to kebab-case)
- Issue body → problem statement, solution ideas
- Comments → additional context, requirements, research links
- Labels → current status, type (blue-sky, enhancement, etc.)

## Phase 2: Analysis & Planning

### Step 2.1: Analyze Issue Content

Read through the issue body and comments to extract:

**Problem/Pain Point**:
- What problem does this solve?
- Why is it worth solving?
- Who experiences this problem?

**Target Users**:
- Who will use this?
- What are their needs/goals?

**Proposed Solution** (if mentioned):
- How does the idea solve the problem?
- What's the core value proposition?

**Key Features** (mentioned or implied):
- What functionality is needed?
- What are the must-haves vs. nice-to-haves?

### Step 2.2: Ask Clarifying Questions

If the issue is vague or missing critical information, use `AskUserQuestion` to clarify:

**Common clarifications needed**:
1. **If target user unclear**: "Who is the primary target user for this idea?"
2. **If problem unclear**: "What's the main problem this solves?"
3. **If features unclear**: "What are the 3-5 most important features?"
4. **If tech unclear**: "Any specific tech stack preferences?" (can also make reasonable defaults)

**Keep it lightweight**: Don't ask for perfect answers, just enough to create a reasonable draft.

### Step 2.3: Identify Core Features

From the issue and clarifications, identify **2-4 core features**:

**Feature selection criteria**:
- Essential for MVP (not nice-to-haves)
- Clearly scoped (not too broad)
- User-facing (not purely technical infrastructure)
- Demonstrable with Gherkin scenarios

**Naming**: Use kebab-case directory names that describe the feature clearly.

Example: `url-parser`, `price-tracking`, `alert-system`

## Phase 3: Create Project Structure

### Step 3.1: Create Directory Structure

Create the project directory with feature subdirectories:

```bash
mkdir -p <project-name>/<feature-1> <project-name>/<feature-2> <project-name>/<feature-3>
```

**Directory naming**:
- Project: Use kebab-case based on issue title
- Features: Use kebab-case, descriptive names

**Verify**: Directory structure created successfully.

### Step 3.2: Draft Main README.md

Use `TEMPLATES/PROJECT_README.md` as a reference, but create a **lighter version**:

**Required sections** (draft quality):

1. **Title and one-liner**
   ```markdown
   # [Project Name]

   > Brief one-line description
   ```

2. **Problem Statement** (1-2 paragraphs)
   - What problem does this solve?
   - Who is it for?
   - Why now? (if relevant)

3. **Solution** (bullet points acceptable)
   - Core value proposition
   - Key features (3-5 items with brief descriptions)

4. **Research** (quick competitive landscape)
   - Use `WebSearch` to find 2-3 existing solutions
   - Create simple comparison table:
     | Solution | Pros | Cons | Pricing |
   - What makes this idea different?

5. **Technical Overview** (reasonable defaults)
   - Potential tech stack (make opinionated but reasonable choices)
   - Key integrations/APIs needed
   - Estimated complexity (Low/Medium/High)

6. **Feature Breakdown**
   - List each feature with brief description
   - Link to feature subdirectory

**Optional/Skip**:
- Detailed effort vs. impact analysis
- Comprehensive market research
- Architecture Decision Records
- Detailed implementation plan

**Tone**: Conversational, focused on "what" not "how", optimistic but realistic.

**Write the file**:

```bash
# Use Write tool to create <project-name>/README.md
```

### Step 3.3: Draft Feature READMEs

For **each feature directory**, create a lightweight `README.md`:

**Required content** (keep under 50 lines):

1. **One-line description**
   ```markdown
   # [Feature Name]

   > Brief description of what this feature does
   ```

2. **User Story**
   ```markdown
   **User Story:**

   As a [type of user]
   I want to [action]
   So that [benefit/value]
   ```

3. **Key Scenarios** (2-3 items)
   - Common use case
   - Important edge case
   - Error handling scenario

4. **Link to Gherkin Spec**
   ```markdown
   ## Specification

   See [`spec.feature`](./spec.feature) for complete behavioral specification.
   ```
   (Even if spec doesn't exist yet for this feature)

**Skip**:
- Detailed UI/UX wireframes
- Complete technical implementation
- Exhaustive acceptance criteria
- Full testing strategy

**Write the files**:

```bash
# Use Write tool for each <project-name>/<feature-name>/README.md
```

### Step 3.4: Create ONE Example Gherkin Spec

Pick the **most important/interesting feature** and create a `spec.feature` file.

**Why only one?**
- Demonstrates the pattern
- Shows level of detail expected
- Faster to create
- User can add more later

**Content to include**:

1. **Feature description** with user story
   ```gherkin
   Feature: [Feature Name]
     As a [user type]
     I want to [action]
     So that [benefit]
   ```

2. **Background** (if common setup needed)
   ```gherkin
   Background:
     Given [common precondition]
     And [another precondition]
   ```

3. **2-3 realistic scenarios**:
   - **Happy path** (successful flow)
   - **Error case** (validation or failure)
   - **Edge case** (optional, if relevant)

**Use TEMPLATES/GHERKIN_EXAMPLE.feature for syntax reference**.

**Keep it practical**:
- Real-world use cases
- Clear Given/When/Then steps
- Not exhaustive - enough to illustrate behavior
- No placeholder values - use realistic examples

**Write the file**:

```bash
# Use Write tool for <project-name>/<feature-name>/spec.feature
```

## Phase 4: Documentation & Communication

### Step 4.1: Create Project Summary

Prepare a summary of what was created:

**Structure**:
```markdown
✅ Draft project created: <project-name>/

📁 Structure:
  - README.md (draft overview)
  - feature-1/ (with spec.feature)
  - feature-2/
  - feature-3/

📝 What's included:
  - Problem statement and target users
  - [N] key features with user stories
  - 1 complete Gherkin spec (<feature-name>)
  - Tech stack suggestions
  - Competitive landscape ([N] alternatives)

🎯 Next steps:
  - Review and refine feature descriptions
  - Add more Gherkin specs as needed
  - Research specific integrations/APIs
  - Ready to move from [current status] → specifying

💬 Updated issue #<number>
```

### Step 4.2: Update Original Issue

Post a comment to the GitHub issue with progress update:

```bash
gh issue comment <number> --repo aliwatters/ideas --body "$(cat <<'EOF'
✅ **Draft Project Structure Created**

I've created a draft project structure for this idea:

## 📁 Directory Structure

```
<project-name>/
├── README.md
├── feature-1/
│   ├── README.md
│   └── spec.feature
├── feature-2/
│   └── README.md
└── feature-3/
    └── README.md
```

## 📝 What's Included

- **Main README.md**: Problem statement, solution overview, [N] key features
- **Feature READMEs**: User stories and scenarios for each feature
- **Gherkin Spec**: Complete behavioral specification for <feature-name>
- **Tech Stack**: Suggested stack based on requirements
- **Competitive Research**: Brief comparison with [N] alternatives

## 🎯 Next Steps

1. Review the structure and provide feedback
2. Refine feature descriptions as needed
3. Add more Gherkin specs for remaining features
4. Research specific APIs/integrations
5. Update status: [current] → specifying

The structure follows the wishfire pattern and is ready for iteration!

See commit: [commit-hash]
EOF
)"
```

**Customize the message**:
- Replace placeholders with actual values
- Add specific questions if there are uncertainties
- Highlight areas that need more detail
- Be encouraging and invite feedback

## Phase 5: Interactive Refinement

### Step 5.1: Offer Refinement Options

Use `AskUserQuestion` to offer refinement options (multiSelect: true):

**Question**: "Would you like to refine or expand any aspect of this draft?"

**Options**:
1. "Expand a specific feature" - Dive deeper into one feature's README/spec
2. "Add more Gherkin specs" - Create specs for additional features
3. "Add missing features" - Identify and add features not yet covered
4. "Research specific aspect" - Deep dive into tech/API/integration research
5. "None - structure looks good" - Complete and move to documentation

### Step 5.2: Execute Refinements

Based on user selections:

**If "Expand a specific feature"**:
- Ask which feature
- Add more detail to README
- Create/expand Gherkin spec
- Add technical considerations

**If "Add more Gherkin specs"**:
- Ask which features (multiselect)
- Create spec.feature for each
- Follow same pattern as first spec

**If "Add missing features"**:
- Discuss what's missing
- Create new feature directories
- Add READMEs and specs

**If "Research specific aspect"**:
- Ask what to research
- Use WebSearch for information
- Add findings to relevant README

**If "None"**:
- Proceed to completion

## Phase 6: Completion

### Step 6.1: Verify Structure

**Checklist**:
- [ ] Project directory exists with clear name
- [ ] Main README.md includes problem, solution, features
- [ ] 2-4 feature directories created
- [ ] Each feature has README.md with user story
- [ ] At least 1 complete Gherkin spec exists
- [ ] Original issue updated with comment
- [ ] Structure follows wishfire pattern

### Step 6.2: Commit Changes

Add and commit the new structure:

```bash
git add <project-name>/
git commit -m "$(cat <<'EOF'
Add draft structure for <project-name>

- Created project overview with problem statement
- Added [N] core features with user stories
- Included example Gherkin spec for <feature>
- Quick competitive analysis
- Tech stack recommendations

Based on issue #<number>

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

### Step 6.3: Output Summary

Display final summary to user:

```
✅ Draft project created: <project-name>/

📁 Structure:
  - README.md (draft overview with problem, solution, features)
  - feature-1/ (core feature with spec)
  - feature-2/ (supporting feature)
  - feature-3/ (nice-to-have feature)

📝 What's included:
  - Problem statement and target users
  - [N] key features with user stories
  - 1 complete Gherkin spec (feature-1)
  - Basic tech stack suggestions
  - Competitive landscape ([N] alternatives found)

🎯 Next steps:
  - Review and refine feature descriptions
  - Add more Gherkin specs if needed
  - Research specific integrations/APIs
  - Ready for status: [current] → specifying

💬 Issue updated: #<number> with progress comment

Committed: [commit-hash]
```

## Success Criteria

- ✅ User selected issue interactively via AskUserQuestion
- ✅ Project directory created with clear, kebab-case name
- ✅ Main README.md covers problem, solution, and features (draft quality)
- ✅ 2-4 feature directories with lightweight READMEs
- ✅ At least 1 complete Gherkin spec created
- ✅ Original issue commented with update and structure summary
- ✅ Structure follows wishfire pattern
- ✅ Quality is "good first draft" - ready to iterate, not perfect

## Key Principles

1. **Interactive**: Use AskUserQuestion for selections and clarifications
2. **Iterative**: Create draft, then offer refinement options
3. **Pragmatic**: Use WebSearch for quick research, make reasonable assumptions
4. **Template-aware**: Reference TEMPLATES/ but don't require perfection
5. **Fast**: Aim for 15-30 min to create initial structure
6. **Opinionated**: Make reasonable choices, document assumptions in READMEs
7. **User-focused**: Keep asking if they want more detail or if draft is sufficient

## Common Pitfalls to Avoid

- ❌ **Over-researching** before creating structure → Do quick search, move on
- ❌ **Too many features** (5+) → Keep it focused, 2-4 core features
- ❌ **Production-quality specs** on first pass → Draft means draft
- ❌ **Skipping user interaction** → This must be collaborative
- ❌ **Perfectionism** → 80% quality is fine for first draft
- ❌ **Echo statements** for output → Provide commands + verification, not status messages

## Tools Required

- `gh issue list` - Fetch issues
- `gh issue view` - Get issue details
- `gh issue comment` - Update issue with progress
- `WebSearch` - Quick competitive research
- `AskUserQuestion` - Interactive selection and refinement
- `Write` - Create README and spec files
- `Read` - Reference TEMPLATES
- `Bash` - git operations

## Related Resources

- **Templates**: `TEMPLATES/` directory in ideas repo
- **Example**: `wishfire/` project structure
- **Gherkin Reference**: `TEMPLATES/GHERKIN_EXAMPLE.feature`
- **Project README Template**: `TEMPLATES/PROJECT_README.md`
- **Feature Spec Template**: `TEMPLATES/FEATURE_SPEC.md`

## Exit Codes

- 0: Draft structure created successfully
- 1: User canceled during selection/refinement
- 2: Error occurred (missing dependencies, permissions, etc.)
