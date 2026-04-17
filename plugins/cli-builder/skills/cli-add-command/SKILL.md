---
name: cli-add-command
description: Activate when the user requests adding a command to an existing TypeScript CLI project. Triggers: "add a command", "new subcommand", "create CLI command", "add command to CLI". Generates command file with Commander, Zod, Chalk, updates barrel exports and bootstrap.
---

# CLI Command Template Generator

## Purpose

Generate a new command template file for an existing TypeScript CLI project. Creates a properly structured command file with Commander definition, Zod validation, Chalk output, and barrel export updates.

## Trigger Conditions

Activate when the user requests adding a new command or subcommand to an existing CLI project.

## Workflow

### Step 1: Identify Target Project

Locate the CLI package by searching for:
- A monorepo with `packages/cli/src/commands/` directory
- A `src/index.ts` file that registers commands via Commander

If multiple candidates exist, ask the user which project to target.

### Step 2: Collect Command Details

Gather the following from the user:

| Field | Description | Required |
|-------|-------------|----------|
| Command name | kebab-case command name (e.g., `deploy`) | Yes |
| Description | One-line description shown in help | Yes |
| Arguments | List of positional arguments (name, description, required) | Optional |
| Options | List of flags (name, shorthand, description, default) | Optional |
| Has interactive prompts | Uses @clack/prompts for input | Yes/No |

### Step 3: Generate Command File

Create the command file at `packages/cli/src/commands/<command-name>.ts` with:

1. **Imports**: Commander, Chalk, Zod, @clack/prompts (if interactive)
2. **Zod schema**: Input validation schema based on arguments and options
3. **Register function**: `register<CommandName>(program: Command)` with:
   - `.command()` — command name
   - `.description()` — description from Step 2
   - `.argument()` — one per argument (if any)
   - `.option()` — one per option (if any)
   - `.action()` — implementation stub with schema validation
4. **Action body**: Implementation stub with proper structure

### Step 4: Update Barrel Exports

Add the export to `packages/cli/src/commands/index.ts`:

```typescript
export { register<CommandName> } from './<command-name>.js'
```

### Step 5: Update Bootstrap

Add the command registration to `packages/cli/src/index.ts`:

```typescript
import { register<CommandName> } from './commands/index.js'
// ...
register<CommandName>(program)
```

### Step 6: Create Test Stub

Create `packages/cli/tests/<command-name>.spec.ts` with a basic test structure:

```typescript
import { describe, it, expect } from 'vitest'

describe('<command-name>', () => {
  it('should register without error', () => {
    // Test stub
  })
})
```

## Template Structure

The generated command file follows the template in `references/command-template.md`.

## Additional Resources

### Reference Files

- **`references/command-template.md`** — Complete command file template with all sections
- **`references/command-patterns.md`** — Common command patterns (interactive, non-interactive, with arguments, with options)

### Examples

- **`examples/init-command.md`** — Example: generated `init` command
- **`examples/add-command.md`** — Example: generated `add` command with arguments and options
