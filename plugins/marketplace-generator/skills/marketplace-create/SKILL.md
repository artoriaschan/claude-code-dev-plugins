---
name: marketplace-create
description: This skill should be used when creating a new Claude Code plugin marketplace project from scratch. Triggers: "create a plugin marketplace", "set up a new marketplace", "scaffold a plugin marketplace", "build a Claude Code plugin collection". Guides through requirements collection, project generation, documentation, and validation.
---

# Marketplace Create

Guide users through creating a complete Claude Code plugin marketplace project. Organized into four phases: Collect, Generate, Document, Validate.

## Trigger

Auto-activate when user asks to create a new plugin marketplace project, or when they mention "create marketplace", "new marketplace", or "plugin market".

## Phase 1: Collect

Ask questions one at a time to gather requirements:

### 1. Marketplace Name
Ask the user for the marketplace project name (kebab-case). Suggest a descriptive name if they're unsure.

### 2. Marketplace Description
Ask what the marketplace is for. Help them write a clear, concise description.

### 3. Plugin Planning
Ask the user what plugins they want to include in the marketplace. Guide them through:
- How many plugins?
- What is each plugin's purpose?
- What components should each plugin have (skills, agents, hooks, rules)?

If the user is unsure, suggest a reasonable default set.

## Phase 2: Generate

After all information is collected, generate the project. Use templates from `references/` directory.

### Directory Structure
```bash
mkdir -p <marketplace-name>/.claude-plugin
mkdir -p <marketplace-name>/plugins
mkdir -p <marketplace-name>/docs/plugins
```

### Plugin Manifests
For each planned plugin, create:
```bash
mkdir -p <marketplace-name>/plugins/<plugin-name>/.claude-plugin
```

Create the manifest using `references/plugin-manifest.md` template. Run `git config user.name` and `git config user.email` to populate the `author` field.

### Plugin README
Create `README.md` for each plugin using `references/plugin-readme.md` template. Run `git config user.name` and `git config user.email` to populate the `## Authors` section.

### marketplace.json
Create `.claude-plugin/marketplace.json` using `references/marketplace-json.md` template. Run `git config user.name` and `git config user.email` to populate the `owner` field.

### Example Plugin
Copy the built-in example plugin from this plugin's `templates/example-plugin/` directory to `<marketplace-name>/plugins/example-plugin/`.

## Phase 3: Document

Generate all documentation. Use templates from `references/` directory.

### CLAUDE.md
Create `<marketplace-name>/CLAUDE.md` using `references/claude-md.md` template. Add one link line per plugin: `- [<plugin-name>](docs/plugins/<plugin-name>.md) — <description>`

### docs/project-structure.md
Create `<marketplace-name>/docs/project-structure.md` using `references/project-structure.md` template. Replace `<marketplace-name>` with actual value.

### docs/plugins/<plugin-name>.md
For each plugin (including example-plugin), create `<marketplace-name>/docs/plugins/<plugin-name>.md` using `references/plugin-doc.md` template. Only include component rows that actually exist for that plugin.

### README.md
Create `<marketplace-name>/README.md` with:
- Marketplace name and description
- List of included plugins (with links to `docs/plugins/`)
- Installation instructions (`marketplace add`)
- Quick start guide
- Link to `docs/project-structure.md` for project layout

## Phase 4: Validate

Use the **marketplace-validator** agent to verify the complete project. Ensure:
- Every plugin in `plugins/` has a valid `.claude-plugin/plugin.json` with `author` field populated
- All plugins in `plugins/` are referenced in `marketplace.json`
- All entries in `marketplace.json` exist in `plugins/`
- `marketplace.json` has correct relative paths and `owner` field populated
- `CLAUDE.md` references correct doc file paths
- `docs/plugins/` has a file for each plugin in `plugins/`
- README plugin list matches `plugins/` directory
- All plugin READMEs have `## Authors` section populated

## Rules

- Ask questions one at a time during Phase 1 (Collect)
- Never skip Phase 1 — always gather requirements before generating
- Validate all plugin names are kebab-case
- Ensure every plugin has a valid `.claude-plugin/plugin.json`
- Copy the example plugin from `templates/example-plugin/` in this plugin
