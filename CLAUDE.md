# Claude Code Plugin Management

## Project Purpose

This project manages Claude Code plugins for personal development workflows. Each plugin under `plugins/` is independently maintained with its own manifest and components.

**Repository:** https://github.com/artoriaschan/claude-code-dev-plugins

## Installation

```bash
# Add marketplace, then install individual plugins
/plugin marketplace add artoriaschan/claude-code-dev-plugins
/plugin install cli-builder
/plugin install code-style

# For code-style rules (remote install, no clone needed)
curl -fsSL https://raw.githubusercontent.com/artoriaschan/claude-code-dev-plugins/main/plugins/code-style/install.sh | bash
```

## Quick Navigation

| Task | Reference |
|------|-----------|
| What is this project and why does it exist | `docs/project-overview.md` |
| Plugin directory layout and manifest format | `docs/plugin-structure.md` |
| How to create plugins, skills, agents | `docs/development-workflow.md` |
| How to install and use plugins | `docs/installation.md` |

## Active Plugins

| Plugin | Components | Purpose |
|--------|-----------|---------|
| `cli-builder` | 2 skills | TypeScript CLI project scaffolding (with simple mode) and command template generation |
| `code-style` | 5 skills, 1 agent, 11 rules | Enforce personal coding style conventions for AI-generated code |

## Key Conventions

- Each plugin has its own `.claude-plugin/plugin.json` manifest
- Plugin files under `plugins/<name>/` — self-contained and independently deployable
- Skills, agents auto-discovered from standard directories
- Code conventions use modern TypeScript patterns (ESM, strict mode)
- Rules installed via `install.sh` — copies to ~/.claude/rules/code-style/
