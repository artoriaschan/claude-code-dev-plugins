# Claude Code Plugins

Personal Claude Code plugin collection for TypeScript CLI development workflows.

## Overview

A curated collection of Claude Code plugins that automate and standardize development tasks. Each plugin is independently maintained with its own manifest and components.

Currently includes **cli-builder** — a TypeScript CLI project scaffolding and code style enforcement tool.

## Plugins

### cli-builder

TypeScript CLI project scaffolding, code style checking, and command template generation following [coding-plans-statusline](https://github.com/artorias/coding-plans-statusline) conventions.

| Component | Type | Purpose |
|-----------|------|---------|
| `cli-create` | Skill | Interactive CLI project creation — guides through configuration and generates complete monorepo scaffolds |
| `cli-check` | Skill | Code style validation — checks projects against coding-plans-statusline conventions |
| `cli-add-command` | Skill | Command template generation — creates individual command files with proper structure |
| `cli-validator` | Agent | Automatic code compliance checker — validates generated code against conventions |
| PostToolUse / SubagentStop | Hooks | Auto-check code style on file write and after subagent execution |

**Generated projects use:**

- TypeScript ESM + Commander + Zod + Chalk 5.x + tsup + Vitest + @clack/prompts
- pnpm workspace + ESLint + Sheriff + Prettier + Husky + Changesets

See [plugins/cli-builder/README.md](plugins/cli-builder/README.md) for plugin-specific documentation.

## Quick Start

### Install a Plugin

Clone this repository and load plugins:

```bash
cc --plugin-dir /path/to/claude-code-plugins
```

### Marketplace

Plugins are cataloged in [`.claude-plugin/marketplace.json`](.claude-plugin/marketplace.json). Submit new plugins by adding an entry to the `plugins` array.

## Project Structure

```
├── .claude-plugin/
│   └── marketplace.json       # Plugin catalog
├── .github/
│   ├── scripts/               # Validation scripts
│   │   ├── validate-marketplace.ts
│   │   ├── check-marketplace-sorted.ts
│   │   └── validate-frontmatter.ts
│   └── workflows/             # CI workflows
│       ├── validate-marketplace.yml
│       └── validate-frontmatter.yml
├── docs/
│   ├── project-overview.md
│   ├── plugin-structure.md
│   └── development-workflow.md
├── plugins/
│   └── cli-builder/
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── README.md
│       ├── agents/
│       ├── hooks/
│       └── skills/
└── CLAUDE.md
```

## Adding a New Plugin

1. Create directory under `plugins/<name>/`
2. Create `.claude-plugin/plugin.json` manifest
3. Add skills, agents, hooks as needed
4. Register the plugin in `.claude-plugin/marketplace.json`

See [docs/development-workflow.md](docs/development-workflow.md) for detailed workflow.

## CI & Validation

GitHub Actions workflows automatically validate PRs:

| Workflow | Triggers On | Checks |
|----------|-------------|--------|
| Validate Marketplace | `.claude-plugin/marketplace.json` changes | JSON format, required fields, no duplicate names, alphabetical sort |
| Validate Frontmatter | Agent/Skill/Command `.md` changes | YAML frontmatter format, required fields |

**Local validation:**

```bash
bun .github/scripts/validate-marketplace.ts .claude-plugin/marketplace.json
bun .github/scripts/check-marketplace-sorted.ts
bun .github/scripts/validate-frontmatter.ts .
```

## License

MIT
