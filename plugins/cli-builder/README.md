# cli-builder

CLI tool builder plugin for Claude Code — TypeScript CLI project scaffolding and command template generation following modern ESM conventions.

## What It Does

Provides two skills for building TypeScript CLI projects:
- `cli-create` — Interactive project creation with pnpm workspace, Commander, Zod, Chalk, and full tooling (ESLint, Sheriff, Prettier, Husky, Changesets)
- `cli-add-command` — Generate individual command files with Commander definitions, Zod validation schemas, Chalk output, and barrel exports

**Simple mode**: Use `simple: true` flag to skip complex tooling (ESLint, Sheriff, Changesets) for lightweight projects.

## Usage

Trigger phrases:
- "create a CLI", "scaffold a CLI project" — generates a complete monorepo project
- "add a command", "create a new CLI command" — generates a command template file

## Components

| Type | Name | Purpose |
|------|------|---------|
| Skill | `cli-create` | Interactive CLI project creation with TypeScript |
| Skill | `cli-add-command` | Generate command template files |

## Tech Stack

Generated projects use:
- TypeScript ESM + Commander + Zod + Chalk 5.x + tsup + Vitest + @clack/prompts
- pnpm workspace + ESLint + Sheriff + Prettier + Husky + Changesets

## Authors

artoriaschan (dalecracker@gmail.com)
