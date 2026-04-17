# Marketplace Generator

Generate complete Claude Code plugin marketplace projects with guided conversation, documentation, and validation.

## Components

| Type | Name | Purpose |
|------|------|---------|
| Skill | `marketplace-create` | Plan and generate complete marketplace projects from scratch |
| Skill | `marketplace-dev-workflow` | Enforce development workflow when adding, updating, or removing plugins |
| Skill | `marketplace-format` | Scan, diagnose, and batch-fix format inconsistencies in existing marketplace projects |
| Agent | `marketplace-validator` | Validate marketplace structure and consistency |
| Template | `example-plugin` | Built-in example plugin with all component types |

## Usage

### Creating a Marketplace

The `marketplace-create` skill auto-activates when you ask to create a plugin marketplace project. It guides you through:

1. **Collect** — Name, description, and plugin planning (one question at a time)
2. **Generate** — Project structure, plugin manifests, and marketplace.json
3. **Document** — CLAUDE.md, project documentation, and per-plugin docs
4. **Validate** — Full structural validation via `marketplace-validator` agent

### Developing Plugins

The `marketplace-dev-workflow` skill auto-activates when detecting changes in the `plugins/` directory. It handles:

- New plugin creation: plan → create → register → validate
- Plugin updates: detect → version bump → cascade update → verify
- Plugin removal: confirm → cleanup → validate

### Formatting Existing Projects

The `marketplace-format` skill auto-activates when you ask to format, fix, or standardize a marketplace project. It runs a 5-phase workflow:

1. **Scan** — Read marketplace.json, CLAUDE.md, README.md, and all plugin structures
2. **Diagnose** — Run 28 checks across 5 categories (project-level, plugin-level, cross-reference, documentation, components)
3. **Confirm** — Present grouped PASS/FAIL report with specific fix instructions
4. **Fix** — Batch-apply all confirmed fixes using shared templates from `marketplace-create/references/`
5. **Verify** — Delegate to `marketplace-validator` agent for final validation

## Generated Project Structure

```
<marketplace-name>/
├── .claude-plugin/
│   └── marketplace.json    # Marketplace configuration
├── CLAUDE.md               # Project context and plugin links
├── README.md               # User-facing documentation
├── docs/
│   ├── project-structure.md # Project layout documentation
│   └── plugins/            # Per-plugin detailed documentation
└── plugins/                # Individual plugins
    ├── plugin-a/
    ├── plugin-b/
    └── example-plugin/     # Built-in example
```
