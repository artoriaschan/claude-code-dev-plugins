# Tech Stack & Code Conventions

Based on coding-plans-statusline project conventions. All generated CLI projects MUST follow these conventions.

## Core Technologies

| Technology | Version | Purpose | Rationale |
|------------|---------|---------|-----------|
| Node.js | >=18.0.0 (20.x LTS recommended) | Runtime | LTS stability, native ESM support |
| TypeScript | 5.4.x+ | Language | Strict type checking, modern ESM support |
| pnpm | 9.x+ | Package Manager | Fast installs, strict peer deps, workspace-native |
| Commander | 13.x | CLI Framework | Mature, lightweight, excellent TS support, auto-generated help |
| Chalk | 5.x | ANSI Colors | ESM-only, minimal overhead, chainable API |
| Zod | 3.24.x | Schema Validation | TypeScript-first, runtime validation, excellent errors |

## Infrastructure

| Technology | Version | Purpose |
|------------|---------|---------|
| tsup | 8.x | Bundler — Zero-config TypeScript Bundling, ESM output |
| tsx | 4.x | TypeScript Execution — Run TS directly in dev, ESM-native |
| Changesets | 2.x | Version Management — Fixed mode (all packages share version) |
| Vitest | 3.x+ | Testing — ESM-native, TypeScript-first, faster than Jest |

## Supporting Libraries

| Library | Version | Purpose |
|---------|---------|---------|
| @clack/prompts | 0.10.x | Interactive Prompts — Modern, beautiful, minimal |

## Development Tools

| Tool | Purpose |
|------|---------|
| ESLint 10.x + typescript-eslint + Sheriff 0.19.x | Linting with module boundary enforcement |
| Prettier 3.x | Code formatting |
| Turborepo 2.x | Build orchestration with caching |
| Husky 9.x + lint-staged 16.x | Git hooks for pre-commit checks |

## What NOT to Use

| Avoid | Why | Use Instead |
|-------|-----|-------------|
| ts-node | Slower than tsx, CommonJS default | tsx (4.x) |
| Jest | CommonJS-first, slow, complex ESM support | Vitest (3.x) |
| Inquirer.js | Large bundle, dated API | @clack/prompts |
| npm/yarn workspaces | Slower installs, less strict deps | pnpm workspaces |
| chalk 4.x | CommonJS, project requires ESM only | chalk 5.x |
| oclif | Overkill for simple CLI, large bundle | Commander |
| Joi | Large bundle, CommonJS default, less TS-native | Zod |

## Code Style Rules

- Single quotes for strings
- 100 character line width
- 4-space indentation
- Barrel exports enforced via Sheriff
- `.spec.ts` naming convention for tests
- TypeScript strict mode enabled

## Directory Conventions

- `core/` — Shared utilities, config, types
- `commands/` (or `feature/`) — Command implementations
- `domain/` — Business logic and core types

## Package.json Scripts Template

```json
{
  "scripts": {
    "prepare": "husky",
    "build": "turbo build",
    "dev": "turbo dev",
    "test": "vitest",
    "test:run": "vitest --run",
    "test:coverage": "vitest --coverage",
    "lint": "pnpm lint:eslint && pnpm lint:sheriff",
    "lint:eslint": "eslint packages/*/src/**/*.ts",
    "lint:sheriff": "sheriff verify",
    "format": "prettier --write .",
    "format:check": "prettier --check .",
    "changeset": "changeset",
    "version": "changeset version",
    "release": "pnpm build && changeset publish"
  }
}
```

## tsconfig.base.json Template

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "lib": ["ES2022"],
    "strict": true,
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "skipLibCheck": true
  }
}
```
