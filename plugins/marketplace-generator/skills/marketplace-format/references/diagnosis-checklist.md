# Diagnosis Checklist

Run all checks below. Group findings by category (A-E). Report each as PASS or FAIL with specific file path and fix instruction.

## A. Project-level (6 checks)

1. `.claude-plugin/marketplace.json` exists and is valid JSON
2. `marketplace.json.name` exists and is non-empty
3. `marketplace.json.description` exists and is non-empty
4. `marketplace.json.owner` has both `name` and `email` fields
5. `marketplace.json.plugins` array exists
6. Each `plugins[].source` starts with `./plugins/` and the directory exists on disk

## B. Plugin-level (6 checks)

7. Each plugin directory has `.claude-plugin/plugin.json`
8. `plugin.json.name` uses kebab-case
9. `plugin.json.version` follows semver (MAJOR.MINOR.PATCH)
10. `plugin.json.description` is non-empty
11. `plugin.json.author` has both `name` and `email` fields
12. Plugin directory name matches `plugin.json.name`

## C. Cross-reference consistency (5 checks)

13. Every `marketplace.json.plugins` entry exists in `plugins/` directory
14. Every `plugins/` subdirectory is registered in `marketplace.json.plugins`
15. `CLAUDE.md` exists at project root and contains a Plugins section
16. `CLAUDE.md` plugin list matches `marketplace.json.plugins` entries
17. Project root `README.md` exists and includes a plugin list

## D. Documentation completeness (5 checks)

18. `docs/project-structure.md` exists at project root
19. `docs/plugins/` directory exists
20. Each plugin has a corresponding `docs/plugins/<plugin-name>.md`
21. Each plugin has `README.md` with `## What It Does`, `## Usage`, `## Authors` sections
22. Each `docs/plugins/<plugin-name>.md` contains: Purpose section, Components table, Version number

## E. Component structure (6 checks)

23. Skills: `skills/<name>/SKILL.md` frontmatter has only `name` and `description` (no `version`)
24. Agents: `agents/<name>.md` frontmatter has `name`, `description`, `model`, and `color`
25. Hooks: `hooks/hooks.json` exists, is valid JSON, has event structure
26. Rules: `rules/` files use kebab-case naming
27. Component frontmatter `name` matches directory or filename
28. Component `description` fields are non-empty
