# Command File Template

Use this template when generating new command files. Replace placeholders in `<angle-brackets>`.

## File: packages/cli/src/commands/<command-name>.ts

```typescript
import { Command } from 'commander'
import chalk from 'chalk'
import { z } from 'zod'

{{#if hasArguments}}
import { <argName>Schema } from '../core/types.js'
{{/if}}

const schema = z.object({
  {{#each options}}
  <optionCamelCase>: z.<optionType>(),
  {{/each}}
})

export function register<CommandName>(program: Command) {
  const cmd = program
    .command('<command-name>')
    .description('<command-description>')
    {{#each arguments}}
    .argument('<arg-name>', '<arg-description>')
    {{/each}}
    {{#each options}}
    .option('<flag>, <shorthand>', '<option-description>'{{#if defaultValue}}, <defaultValue>{{/if}})
    {{/each}}

  cmd.action(async ({{#each arguments}}<argName>, {{/each}}opts) => {
    const parsed = schema.safeParse(opts)

    if (!parsed.success) {
      console.error(chalk.red('Invalid options:'), parsed.error.message)
      process.exit(1)
    }

    {{#if hasInteractivePrompts}}
    // Interactive prompt example
    // const result = await text({ message: 'Enter value' })
    {{/if}}

    console.log(chalk.green('<command-name> completed'))
  })
}
```

## Conventions

- File name: kebab-case (`my-command.ts`)
- Function name: PascalCase (`registerMyCommand`)
- Single quotes for strings
- 4-space indentation
- `.js` extension in imports
- Zod schema for all input validation
- Chalk for colored output
- @clack/prompts for interactive input
