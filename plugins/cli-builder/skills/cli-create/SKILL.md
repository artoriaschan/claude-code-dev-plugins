---
name: cli-create
description: Activate when the user requests creating a new TypeScript CLI project from scratch. Triggers: "create a CLI tool", "scaffold a CLI project", "new CLI monorepo", "bootstrap TypeScript CLI". Generates a pnpm-based project with Commander, Zod, Chalk, and full tooling.
---

# CLI Project Creator

## Purpose

Generate a complete TypeScript CLI project scaffold through interactive user prompts. Supports monorepo (pnpm workspace + Turborepo) and simple (single package) structures. Core stack: Commander, Zod, Chalk 5.x, tsup, Vitest, @clack/prompts, ESLint, Prettier, Husky, and Changesets.

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
| `projectType` | Project structure — `monorepo` or `simple` | `simple` (Recommended) |
| `commands` | List of subcommands to create | `["init", "list", "run"]` |
| `authorName` | Author name | `artorias` |

For each command in the list, also collect:
- Command name (kebab-case)
- Command description
- Whether it accepts arguments (yes/no)
- Whether it has options/flags (yes/no)

### Step 2: Generate Project Scaffold

Generate the project structure based on `projectType`:

#### Monorepo (`projectType: "monorepo"`)

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

#### Simple (`projectType: "simple"`)

```
project-root/
├── .claude-plugin/
│   └── plugin.json
├── .github/
│   └── workflows/
│       └── ci.yml
├── .husky/
│   └── pre-commit
├── src/
│   ├── core/
│   │   ├── config.ts
│   │   └── types.ts
│   ├── commands/
│   │   └── <command>.ts   (one per user-specified command)
│   └── index.ts
├── tests/
│   └── <command>.spec.ts
├── .gitignore
├── .npmrc
├── eslint.config.js
├── package.json
├── tsconfig.json
├── vitest.config.ts
└── tsup.config.ts
```

### Step 3: Apply Code Conventions

All generated code MUST follow conventions from `references/tech-stack.md`:

- TypeScript ESM only (`"type": "module"`)
- Barrel exports enforced via Sheriff
- `.spec.ts` test naming
- TypeScript strict mode enabled
- Directory conventions: `domain/` `core/` `feature/`
- Zod for schema validation
- Commander for CLI commands
- Chalk 5.x for terminal colors
- @clack/prompts for interactive prompts
- Vitest for testing
- Changesets for version management (fixed mode)

### Step 4: Generate Command Templates

For each user-specified command, create a command file:
- **Monorepo:** `packages/cli/src/commands/<command>.ts`
- **Simple:** `src/commands/<command>.ts`

Follow the template structure in `references/command-template.md` (from the cli-add-command skill at `../cli-add-command/references/command-template.md`).

Each command file includes:
1. Commander command definition with `.command()`, `.description()`, `.argument()`, `.option()`, `.action()`
2. Zod schema for input validation
3. Chalk-colored output
4. Export from barrel file (`src/index.ts` or `packages/cli/src/index.ts`)

### Step 5: Configure Tooling

Generate configuration files based on `projectType`:

**Both types:**
- `package.json` — project config and scripts (build, dev, test, lint, format, release)
- `tsconfig.json` (or `tsconfig.base.json` for monorepo) — TypeScript config (ESM, strict, moduleResolution: "NodeNext")
- `vitest.config.ts` — testing config
- `eslint.config.ts` — linting
- `.husky/pre-commit` — lint-staged hook

**Monorepo only:**
- `pnpm-workspace.yaml` — workspace definition
- `turbo.json` — build orchestration
- `sheriff.config.ts` — module boundary rules
- `vitest.workspace.ts` — workspace test config

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
- **`references/scaffold-structure.md`** — Detailed project structure explanation and file templates
- **`../cli-add-command/references/command-template.md`** — Command file template used by both cli-create and cli-add-command

### Examples

- **`examples/generated-project.md`** — Example of a complete generated project output
