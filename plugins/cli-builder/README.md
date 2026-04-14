# cli-builder

CLI tool builder plugin for Claude Code — TypeScript CLI project scaffolding, code style checking, and command template generation following coding-plans-statusline conventions.

## Components

### Skills

| Skill | Trigger | Purpose |
|-------|---------|---------|
| `cli-create` | "create a CLI", "scaffold a CLI project" | Interactive CLI project creation with TypeScript |
| `cli-check` | "check CLI code style", "lint my CLI project" | Validate CLI projects against code conventions |
| `cli-add-command` | "add a command", "create a new CLI command" | Generate command template files |

### Agents

| Agent | Purpose |
|-------|---------|
| `cli-validator` | Automatically validates generated code against conventions |

### Hooks

| Event | Purpose |
|-------|---------|
| PostToolUse (Write/Edit) | Check .ts files for convention violations |
| SubagentStop | Verify generated code follows conventions |

## Settings

Configure defaults in `~/.claude/plugins/cli-builder.local.md`:

```markdown
---
defaultIndentation: 4
defaultQuoteStyle: single
defaultLineWidth: 100
enforceBarrelExports: true
enforceTestNaming: true
---
```

See README for full settings reference.

## Tech Stack

Generated projects use:
- TypeScript ESM + Commander + Zod + Chalk 5.x + tsup + Vitest + @clack/prompts
- pnpm workspace + ESLint + Sheriff + Prettier + Husky + Changesets
