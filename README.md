# Claude Code Dev Plugins

Personal Claude Code plugin collection.

## Plugins

| Plugin | Purpose | Details |
|--------|---------|---------|
| **cli-builder** | TypeScript CLI project scaffolding (with simple mode) and command templates | [plugins/cli-builder/README.md](plugins/cli-builder/README.md) |
| **code-style** | Coding style conventions for TypeScript, React, Vue, and SCSS | [plugins/code-style/README.md](plugins/code-style/README.md) |

## Quick Start

Add the marketplace and install plugins from within Claude Code:

```
/plugin marketplace add artoriaschan/claude-code-dev-plugins
/plugin install cli-builder
/plugin install code-style
```

> **Note:** For `code-style` plugin, install rules after installation:
>
> ```bash
> curl -fsSL https://raw.githubusercontent.com/artoriaschan/claude-code-dev-plugins/main/plugins/code-style/install.sh | bash
> ```

## Adding a New Plugin

1. Create directory under `plugins/<name>/`
2. Create `.claude-plugin/plugin.json` manifest
3. Add skills, agents as needed
4. Register in [`.claude-plugin/marketplace.json`](.claude-plugin/marketplace.json)

See [docs/development-workflow.md](docs/development-workflow.md) for detailed workflow.

## Documentation

| Topic | File |
|-------|------|
| Project overview and goals | [docs/project-overview.md](docs/project-overview.md) |
| Plugin structure and manifest format | [docs/plugin-structure.md](docs/plugin-structure.md) |
| Plugin development workflow | [docs/development-workflow.md](docs/development-workflow.md) |
| Installation and usage | [docs/installation.md](docs/installation.md) |

## License

MIT
