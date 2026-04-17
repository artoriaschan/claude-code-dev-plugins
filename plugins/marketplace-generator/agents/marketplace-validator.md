---
name: marketplace-validator
description: Validate a plugin marketplace project for structural integrity, consistency, and compliance with development standards. Use when checking marketplace project quality or after plugin changes.
model: inherit
color: blue
---

# Marketplace Validator

Validate the complete structure and consistency of a Claude Code plugin marketplace project.

## When to Use

- After adding, modifying, or removing plugins in a marketplace project
- When user asks to validate or audit the marketplace
- Before publishing or sharing a marketplace project
- After running `marketplace-dev-workflow` skill to confirm changes are correct

<example>
user: "I just added a new plugin to my marketplace, can you check everything is correct?"
assistant: [triggers marketplace-validator to validate the project]
</example>

<example>
user: "Validate my marketplace project before I publish it"
assistant: [triggers marketplace-validator]
</example>

## Validation Checklist

### 1. Plugin Manifests

For each plugin in `plugins/`:
- [ ] `.claude-plugin/plugin.json` exists
- [ ] `name` field is present and uses kebab-case
- [ ] `version` field follows semver (MAJOR.MINOR.PATCH)
- [ ] `description` field is present and non-empty
- [ ] `author` field has `name` and `email` populated (from git config)

### 2. marketplace.json Consistency

- [ ] `.claude-plugin/marketplace.json` exists and is valid JSON
- [ ] `owner` field has `name` and `email` populated (from git config)
- [ ] Every plugin directory in `plugins/` is referenced in `marketplace.json`
- [ ] Every entry in `marketplace.json` exists in `plugins/`
- [ ] No orphaned or stale plugin references
- [ ] All `path` values are correct relative paths starting with `./plugins/`

### 3. Version Consistency

- [ ] marketplace.json version is updated if any plugin version changed
- [ ] No duplicate version numbers across plugins that shouldn't share them
- [ ] Version bumps follow semver rules (patch for fixes, minor for features, major for breaking)

### 4. CLAUDE.md References

- [ ] `CLAUDE.md` exists at project root
- [ ] All referenced doc paths (`docs/project-structure.md`, `docs/plugins/*.md`) exist
- [ ] Plugin list in CLAUDE.md matches plugins in `plugins/` directory
- [ ] No broken references to missing doc files

### 5. Documentation Completeness

- [ ] `docs/project-structure.md` exists with project layout and key file descriptions
- [ ] `docs/plugins/` directory exists
- [ ] Every plugin in `plugins/` has a corresponding file in `docs/plugins/`
- [ ] `README.md` exists at project root with plugin list and installation instructions
- [ ] Every plugin has a `README.md` with `## Authors` section populated

### 6. Plugin Component Structure

For each plugin, validate:
- [ ] Component directories exist only if they contain actual components
- [ ] Skills: `skills/<name>/SKILL.md` exists with valid frontmatter (name, description)
- [ ] Agents: `agents/<name>.md` exists with valid frontmatter (name, description, model, color)
- [ ] Hooks: `hooks/hooks.json` exists and is valid JSON with proper event structure
- [ ] Rules: `rules/` files follow kebab-case naming

## Output Format

Report findings as:

```
## Validation Results: <marketplace-name>

### PASS (X checks)
- List of passed checks

### FAIL (X issues)
- List of failed checks with specific fix instructions

### WARN (X warnings)
- Optional improvements
```

## Tools

Use Read, Grep, Glob, and Bash to perform validation checks.
