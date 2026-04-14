# Scaffold Structure Reference

## Monorepo Overview

The generated project is a pnpm monorepo with Turborepo orchestration. All packages share a unified version via Changesets fixed mode.

## Root Files

### package.json (root)

- `private: true` — prevents accidental publishing
- `type: "module"` — ESM-only
- `packageManager` field with pnpm version
- `engines.node` >= 18.0.0
- DevDependencies: typescript, tsup, vitest, eslint, prettier, husky, lint-staged, changesets, turbo, sheriff

### pnpm-workspace.yaml

```yaml
packages:
  - 'packages/*'
```

### tsconfig.base.json

Shared base config inherited by all packages. ESM settings, strict mode, NodeNext resolution.

### turbo.json

Build orchestration with caching. Defines task dependencies (build depends on ^build, test depends on build).

### vitest.config.ts + vitest.workspace.ts

Root vitest config. Workspace references all packages. Coverage via @vitest/coverage-v8.

### eslint.config.js

Flat config with typescript-eslint, sheriff, prettier. Imports and barrel export rules.

### sheriff.config.ts

Module boundary enforcement. Defines allowed imports between packages.

### .husky/pre-commit

Runs lint-staged before commits.

### .gitignore

```
node_modules/
dist/
types/
*.local.*
.claude/
```

## Package Structure

Each package in `packages/` follows:

```
packages/<name>/
├── package.json        # Package-specific config
├── tsconfig.json       # Extends root tsconfig.base.json
├── tsconfig.build.json # Build-specific config
├── src/
│   ├── index.ts        # Barrel export
│   ├── core/           # Shared utilities
│   └── commands/       # Command implementations
└── tests/              # Test files (*.spec.ts)
```

### CLI Package (packages/cli)

The main CLI package. Contains:

- `package.json` with `bin` field pointing to dist entry
- `src/index.ts` — bootstrap file, registers Commander program
- `src/commands/` — one file per subcommand
- `src/core/` — config loading, types, utilities
- `scripts/generate-schemas.ts` — generates JSON schemas from Zod

### Widget-Renderer Package (packages/widget-renderer)

Shared rendering library. Contains:

- `src/index.ts` — barrel export of widget types and renderers
- Config schema exports

### Usage Adapter Package (optional)

Adapter for external APIs. Dynamic import pattern.

## File Templates

### Command Template

```typescript
import { Command } from 'commander'
import chalk from 'chalk'
import { z } from 'zod'

const schema = z.object({})

export function registerCommand(program: Command) {
  program
    .command('name')
    .description('description')
    .action(async () => {
      // implementation
    })
}
```

### Barrel Export Template

```typescript
export { registerInit } from './commands/init.js'
export { registerList } from './commands/list.js'
```

### Config Template

```typescript
import { z } from 'zod'
import { readFileSync, existsSync } from 'node:fs'

const configSchema = z.object({})

export function loadConfig(path: string) {
  if (!existsSync(path)) return {}
  const raw = readFileSync(path, 'utf-8')
  return configSchema.parse(JSON.parse(raw))
}
```
