# Claude Code Dev Plugins

Personal Claude Code plugin collection.

## Plugins

| Plugin | Purpose | Details |
|--------|---------|---------|
| **cli-builder** | TypeScript CLI project scaffolding and code style enforcement | [plugins/cli-builder/README.md](plugins/cli-builder/README.md) |
| **code-style** | Coding style conventions for TypeScript, React, Vue, and SCSS | [plugins/code-style/README.md](plugins/code-style/README.md) |

## Quick Start

Add the marketplace and install plugins from within Claude Code:

```
/plugin marketplace add artoriaschan/claude-code-dev-plugins
/plugin install cli-builder
/plugin install code-style
```

Or from the CLI:

```bash
claude plugin install github:artoriaschan/claude-code-dev-plugins
```

> **Note:** For `code-style` plugin, link rules after installation:
>
> ```bash
> ln -s "$(pwd)/plugins/code-style/rules" ~/.claude/rules/code-style
> ```

## Adding a New Plugin

1. Create directory under `plugins/<name>/`
2. Create `.claude-plugin/plugin.json` manifest
3. Add skills, agents, hooks as needed
4. Register in [`.claude-plugin/marketplace.json`](.claude-plugin/marketplace.json)

See [docs/development-workflow.md](docs/development-workflow.md) for detailed workflow.

## Documentation

| Topic | File |
|-------|------|
| Project overview and goals | [docs/project-overview.md](docs/project-overview.md) |
| Plugin structure and manifest format | [docs/plugin-structure.md](docs/plugin-structure.md) |
| Plugin development workflow | [docs/development-workflow.md](docs/development-workflow.md) |
| Installation and usage | [docs/installation.md](docs/installation.md) |
| Coding conventions | [docs/coding-conventions.md](docs/coding-conventions.md) |

## License

MIT
