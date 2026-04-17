# Project Structure

claude-code-dev-plugins is a Claude Code plugin marketplace project.

## Directory Layout

```
claude-code-dev-plugins/
├── .claude-plugin/
│   └── marketplace.json    # Registry of all plugins in this marketplace
├── CLAUDE.md               # Project context for Claude Code
├── README.md               # User-facing documentation
├── docs/
│   ├── project-structure.md # This file
│   ├── project-overview.md  # Project goals and motivation
│   ├── plugin-structure.md  # Plugin manifest and component format
│   ├── development-workflow.md  # Plugin development workflow
│   └── plugins/            # Per-plugin detailed documentation
│       ├── cli-builder.md
│       ├── code-style.md
│       └── marketplace-generator.md
└── plugins/
    ├── cli-builder/        # TypeScript CLI scaffolding
    ├── code-style/         # Coding style conventions
    └── marketplace-generator/  # Marketplace project generator
```

## Key Files

### .claude-plugin/marketplace.json

The marketplace configuration file. Contains:
- `name`: Marketplace name (kebab-case)
- `description`: Purpose statement
- `owner`: Marketplace owner (name + email)
- `plugins[]`: Array of plugin entries with name, description, category, source path, tags, and components

### CLAUDE.md

Project-level context for Claude Code. Links to plugin documentation and defines active plugins table.

## How Plugins Work

Each plugin in `plugins/` is a self-contained Claude Code plugin with its own manifest at `.claude-plugin/plugin.json`. The `marketplace.json` file at the root registers all plugins for distribution. Users can install the entire marketplace and selectively enable individual plugins.

## Plugin Conventions

- Each plugin has its own `plugin.json` manifest with name, version, description, and author
- Skills live in `skills/<skill-name>/SKILL.md`
- Agents live in `agents/<agent-name>.md`
- Rules live in `rules/<category>/<rule-name>.md`
- Each plugin has a `README.md` with What It Does, Usage, and Authors sections
