# Claude Code Plugin Management

## Project Purpose

This project manages Claude Code plugins for personal development workflows. Each plugin under `plugins/` is independently maintained with its own manifest and components.

## Structure

```
├── CLAUDE.md                    # Project context and documentation index
├── docs/                        # Project documentation (split from CLAUDE.md)
└── plugins/
    └── <plugin-name>/
        ├── .claude-plugin/
        │   └── plugin.json      # Plugin manifest (per-plugin)
        ├── README.md
        ├── agents/
        ├── hooks/
        └── skills/
```

## Active Plugins

| Plugin | Components | Purpose |
|--------|-----------|---------|
| `cli-builder` | 3 skills, 1 agent, 1 hook | TypeScript CLI project scaffolding and code style checking |

## Key Conventions

- Each plugin has its own `.claude-plugin/plugin.json` manifest
- Plugin files under `plugins/<name>/` — self-contained and independently deployable
- Skills, agents, hooks auto-discovered from standard directories
- Code conventions follow coding-plans-statusline project patterns (TypeScript ESM, single quotes, 4-space indent)

## Documentation

| Topic | File |
|-------|------|
| Project overview and goals | `docs/project-overview.md` |
| Plugin structure and manifest format | `docs/plugin-structure.md` |
| Plugin development workflow | `docs/development-workflow.md` |
