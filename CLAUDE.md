# Claude Code Plugin Management

## Project Purpose

This project manages Claude Code plugins for personal development workflows. Each plugin under `plugins/` is independently maintained with its own manifest and components.

**Repository:** https://github.com/artoriaschan/claude-code-dev-plugins

## Quick Navigation

| Task | Reference |
|------|-----------|
| What is this project and why does it exist | `docs/project-overview.md` |
| Plugin directory layout and manifest format | `docs/plugin-structure.md` |
| How to develop plugins | `docs/development-workflow.md` |

## Active Plugins

| Plugin | Components | Purpose |
|--------|-----------|---------|
| `cli-builder` | 2 skills | TypeScript CLI project scaffolding (with simple mode) and command template generation |
| `code-style` | 5 skills, 1 agent, 11 rules | Enforce personal coding style conventions for AI-generated code |
| `marketplace-generator` | 3 skills, 1 agent | Generate complete Claude Code plugin marketplace projects with guided workflows and format existing projects |

## Key Conventions

- Each plugin has its own `.claude-plugin/plugin.json` manifest
- Plugin files under `plugins/<name>/` — self-contained and independently deployable
- Skills, agents auto-discovered from standard directories
- Code conventions use modern TypeScript patterns (ESM, strict mode)
