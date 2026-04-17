---
name: marketplace-dev-workflow
description: Triggers when creating, updating, or removing plugins in a marketplace project. Use when the user says "add a new plugin", "create a plugin for X", "update the X plugin", "remove X plugin", or when files under plugins/ are modified. Enforces development workflow, structure validation, and version management.
---

# Marketplace Development Workflow

Enforce proper development workflow when creating, modifying, or updating plugins in a marketplace project. Trigger automatically when detecting changes in `plugins/` directory.

## Trigger

Auto-activate when:
- A new plugin directory is created under `plugins/`
- Files inside `plugins/` are modified
- User mentions adding, updating, or removing plugins

## Workflow: New Plugin

### 1. Plan

Before creating any files, confirm:
- Plugin name (kebab-case)
- Plugin description
- Required components (skills, agents, hooks, rules)

### 2. Create

Generate plugin structure:
```
plugins/<plugin-name>/
├── .claude-plugin/
│   └── plugin.json
├── skills/          # if needed
├── agents/          # if needed
├── hooks/           # if needed
├── rules/           # if needed
└── README.md
```

Create the plugin's `.claude-plugin/plugin.json` with `author` field populated from `git config user.name` and `git config user.email`.

Create `README.md` for the plugin following the official format:
- Plugin name and one-line description
- `## What It Does` section
- `## Usage` section
- `## Authors` section with git user.name and user.email

Validate:
- `plugin.json` has required `name`, `description`, `author` fields
- All directories follow naming conventions
- Component files have valid frontmatter

### 3. Register

Update `.claude-plugin/marketplace.json`:
- Add plugin entry to `plugins` array
- Set correct relative path
- Update marketplace version if needed

Update project root `README.md`:
- Add new plugin to the included plugins list
- Include plugin name, description, and link to its README

Update `CLAUDE.md`:
- Add plugin entry to the `## Plugins` section: `- [<plugin-name>](docs/plugins/<plugin-name>.md) — <description>`

Create `docs/plugins/<plugin-name>.md`:
- Plugin purpose and description
- Component table listing all skills, agents, hooks, rules
- Current version number

### 4. Verify

Use the **marketplace-validator** agent to run the full validation checklist:
- Plugin manifests validity
- marketplace.json consistency
- Version numbering
- CLAUDE.md references
- Documentation completeness
- Component structure

## Workflow: Update Plugin

### 1. Detect Change

Identify what changed:
- Plugin manifest modified → trigger version bump
- Components added/removed → validate structure + update plugin README
- Plugin description changed → update marketplace.json and plugin README

**Update plugin README** when components change:
- Add new components to the component list
- Remove components that are no longer present
- Do not list removed or deprecated components

### 2. Version Bump

When plugin manifest changes, propose a version change:
- Increment patch version for minor changes
- Increment minor version for new features
- Increment major version for breaking changes

Ask the user to confirm the version bump before applying it. Explain the proposed change and rationale.

### 3. Cascade Update

After the user confirms the version bump:
- Update `marketplace.json` version (bump whenever any plugin version changes)
- If marketplace description changed, update marketplace.json
- Verify all plugin entries are consistent

Update project root `README.md` when marketplace structure changes:
- Add new plugins to the plugins list
- Update plugin descriptions if changed
- Remove entries for deleted plugins

Update `CLAUDE.md`:
- Add/remove plugin entries in the `## Plugins` section as needed
- Update descriptions if changed

Update `docs/plugins/<plugin-name>.md`:
- Update component table to reflect added/removed components
- Update version number

### 4. Verify Consistency

Use the **marketplace-validator** agent to confirm:
- All plugins in `plugins/` are referenced in `marketplace.json`
- All entries in `marketplace.json` exist in `plugins/`
- No stale or broken references
- Version numbers follow semver
- CLAUDE.md references are valid

## Workflow: Remove Plugin

### 1. Confirm

Ask user to confirm plugin removal.

### 2. Update

- Remove plugin directory
- Remove entry from `marketplace.json`
- Update marketplace version
- Remove plugin from project root `README.md` plugin list
- Remove plugin entry from `CLAUDE.md` `## Plugins` section
- Remove `docs/plugins/<plugin-name>.md`

### 3. Verify

Use the **marketplace-validator** agent to ensure no dangling references and all checks pass.

## Rules

- Never modify plugin files without user confirmation
- Always update `marketplace.json` when plugins change
- Enforce kebab-case naming for all plugin names
- Validate plugin structure after every change
- Keep marketplace.json version in sync with plugin version changes (bump when any plugin version changes)
