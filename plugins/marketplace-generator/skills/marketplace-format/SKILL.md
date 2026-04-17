---
name: marketplace-format
description: Scans an existing plugin marketplace project for 28 format and consistency checks (manifest validation, cross-references, documentation, component structure) and batch-fixes all issues. Use when the user says "format marketplace", "fix plugin structure", "standardize plugins", "check marketplace format", or asks to audit or repair a marketplace project.
---

# Marketplace Format

Scan an existing plugin marketplace project, diagnose all format inconsistencies, and batch-fix them to match the recommended structure.

## Relationship to marketplace-validator

This skill and the **marketplace-validator** agent share the same diagnosis criteria. The difference:
- **marketplace-format** (this skill): scan + diagnose + batch-fix. Use when you want to repair a project.
- **marketplace-validator**: read-only audit. Use when you want to verify a project is already correct.

Phase 5 of this skill delegates to the validator agent for final verification.

## Workflow

### Phase 1: Scan

1. Locate the project root (directory containing `.claude-plugin/marketplace.json`)
2. Read `.claude-plugin/marketplace.json` — extract all plugin entries
3. Read `CLAUDE.md` at project root
4. Read `README.md` at project root (if exists)
5. For each plugin in `marketplace.json.plugins`, scan its directory structure
6. Check `docs/project-structure.md` and `docs/plugins/` (if exist)
7. Run `git config user.name` and `git config user.email` for author defaults

### Phase 2: Diagnose

Run all 28 checks from `references/diagnosis-checklist.md`. Generate a report grouped by category (A-E):

- A: Project-level (6 checks)
- B: Plugin-level (6 checks)
- C: Cross-reference consistency (5 checks)
- D: Documentation completeness (5 checks)
- E: Component structure (6 checks)

### Phase 3: Confirm

Present the diagnosis report to the user grouped by category. Show PASS items briefly, FAIL items with specific fix instructions. Ask user to confirm before applying fixes.

### Phase 4: Fix

Apply all confirmed fixes:

**Project-level:** add missing `owner.email`, fix invalid `plugins[].source` paths

**Plugin-level:** create missing `plugin.json` (use `marketplace-create/references/plugin-manifest.md` template), add missing `author.name` + `author.email`, normalize directory names to kebab-case

**Cross-reference:** sync unregistered/stale plugins between `marketplace.json` and `plugins/`, update `CLAUDE.md` and `README.md` plugin lists

**Documentation:** generate missing `docs/project-structure.md` (use `marketplace-create/references/project-structure.md`), create missing `docs/plugins/<plugin-name>.md` (use `marketplace-create/references/plugin-doc.md`), rewrite plugin `README.md` to official format (use `marketplace-create/references/plugin-readme.md`)

**Components:** remove `version` from skill frontmatter, add missing `model` + `color` to agent frontmatter, fix kebab-case naming for rules

### Phase 5: Verify

Use the **marketplace-validator** agent to run the full validation checklist. Report final PASS/FAIL results.

## Rules

- Never apply fixes without user confirmation
- Always use git config values for author/owner fields
- Preserve existing content when generating missing files — only add missing sections
- When rewriting README, keep existing What It Does content, reformat structure only
- Templates are shared from `marketplace-create/references/` directory — both skills use the same source of truth
