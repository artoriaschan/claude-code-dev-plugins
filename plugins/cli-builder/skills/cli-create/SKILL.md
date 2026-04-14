---
name: cli-create
description: This skill should be used when the user asks to "create a CLI tool", "scaffold a CLI project", "bootstrap a TypeScript CLI", "generate a new CLI", "start a new CLI project", or mentions creating command-line applications with interactive prompts. Guides interactive CLI project creation with TypeScript following coding-plans-statusline conventions.
version: 0.1.0
---

# CLI Project Creator

## Purpose

Generate a complete TypeScript CLI project scaffold through interactive user prompts, following the coding-plans-statusline project conventions: TypeScript ESM, Commander, Zod, Chalk 5.x, tsup, Vitest, @clack/prompts, pnpm workspace, ESLint + Sheriff, Prettier, Husky, and Changesets.

## Trigger Conditions

Activate when the user requests creating a new CLI tool, scaffolding a CLI project, or generating command-line application boilerplate.

## Workflow

### Step 1: Collect Project Configuration

Present the user with an interactive questionnaire to gather the following required fields:

| Field | Description | Example |
|-------|-------------|---------|
| `projectName` | Package name (kebab-case) | `my-tool` |
| `description` | Short project description | `A tool for managing X` |
| `binName` | CLI command name | `my-tool` |
| `commands` | List of subcommands to create | `["init", "list", "run"]` |
| `authorName` | Author name | `artorias` |

For each command in the list, also collect:
- Command name (kebab-case)
- Command description
- Whether it accepts arguments (yes/no)
- Whether it has options/flags (yes/no)

### Step 2: Generate Project Scaffold

Generate the complete project structure:

```
project-root/
├── .claude-plugin/
│   └── plugin.json
├── .github/
│   └── workflows/
│       └── ci.yml
├── .husky/
│   └── pre-commit
├── packages/
│   ├── cli/
│   │   ├── schemas/
│   │   ├── scripts/
│   │   │   └── generate-schemas.ts
│   │   └── src/
│   │       ├── core/
│   │       │   ├── config.ts
│   │       │   └── types.ts
│   │       ├── commands/
│   │       │   └── <command>.ts   (one per user-specified command)
│   │       └── index.ts
│   └── widget-renderer/
│       └── src/
│           └── index.ts
├── .gitignore
├── .npmrc
├── eslint.config.js
├── package.json
├── pnpm-workspace.yaml
├── sheriff.config.ts
├── tsconfig.base.json
├── turbo.json
├── vitest.config.ts
└── vitest.workspace.ts
```

### Step 3: Apply Code Conventions

All generated code MUST follow conventions from `references/tech-stack.md`:

- TypeScript ESM only (`"type": "module"`)
- Single quotes, 4-space indent, 100 char line width
- Barrel exports enforced via Sheriff
- `.spec.ts` test naming
- Directory conventions: `domain/` `core/` `feature/`
- Zod for schema validation
- Commander for CLI commands
- Chalk 5.x for terminal colors
- @clack/prompts for interactive prompts
- Vitest for testing
- Changesets for version management (fixed mode)

### Step 4: Generate Command Templates

For each user-specified command, create a command file in `packages/cli/src/commands/<command>.ts` with:

1. Commander command definition with `.command()`, `.description()`, `.argument()`, `.option()`, `.action()`
2. Zod schema for input validation
3. Chalk-colored output
4. Export from barrel file

### Step 5: Configure Tooling

Generate all configuration files:

- `package.json` — root workspace config, scripts (build, dev, test, lint, format, changeset, release)
- `tsconfig.base.json` — shared TypeScript config (ESM, strict, moduleResolution: "NodeNext")
- `turbo.json` — build orchestration
- `vitest.config.ts` + `vitest.workspace.ts` — testing config
- `eslint.config.ts` — linting with Sheriff
- `sheriff.config.ts` — module boundary rules
- `.husky/pre-commit` — lint-staged hook
- `pnpm-workspace.yaml` — workspace definition

### Step 6: Verify and Report

After generation, verify:
- All files created successfully
- `pnpm install` runs without errors
- `pnpm build` completes
- `pnpm test:run` passes (initial empty tests)

Report the generated structure and next steps to the user.

## Additional Resources

### Reference Files

- **`references/tech-stack.md`** — Complete tech stack details, version constraints, and code conventions
- **`references/scaffold-structure.md`** — Detailed monorepo structure explanation and file templates

### Examples

- **`examples/generated-project.md`** — Example of a complete generated project output

### Scripts

- **`scripts/generate-project.sh`** — Helper script to scaffold project from template
