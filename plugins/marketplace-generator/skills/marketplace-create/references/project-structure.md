# docs/project-structure.md Template

Replace `<marketplace-name>` with actual value.

```markdown
# Project Structure

<marketplace-name> is a Claude Code plugin marketplace project.

## Directory Layout

```
<marketplace-name>/
├── .claude-plugin/
│   └── marketplace.json    # Registry of all plugins in this marketplace
├── CLAUDE.md               # Project context for Claude Code
├── README.md               # User-facing documentation
├── docs/
│   ├── project-structure.md # This file
│   └── plugins/            # Per-plugin detailed documentation
└── plugins/
    └── <plugin-name>/      # Individual plugins
        ├── .claude-plugin/
        │   └── plugin.json # Plugin manifest
        ├── skills/         # Auto-activating skills (if any)
        ├── agents/         # Subagent definitions (if any)
        ├── hooks/          # Event handlers (if any)
        ├── rules/          # Custom rules (if any)
        └── README.md       # Plugin documentation
```

## Key Files

### .claude-plugin/marketplace.json
The marketplace configuration file. Contains:
- `name`: Marketplace name (kebab-case)
- `version`: Semver version
- `description`: Purpose statement
- `plugins[]`: Array of { name, path } objects pointing to each plugin

### CLAUDE.md
Project-level context for Claude Code. Links to plugin documentation.

## How Plugins Work
Each plugin in `plugins/` is a self-contained Claude Code plugin with its own manifest.
The marketplace.json file at the root registers all plugins for distribution.
Users can install the entire marketplace and selectively enable individual plugins.
```
