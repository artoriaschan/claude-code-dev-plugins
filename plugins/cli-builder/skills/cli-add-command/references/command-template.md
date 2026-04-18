# 命令文件模板

在生成新命令文件时使用此模板。替换 `<尖括号>` 中的占位符。

## 文件：packages/cli/src/commands/<command-name>.ts

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

## 约定

- 文件名：kebab-case（`my-command.ts`）
- 函数名：PascalCase（`registerMyCommand`）
- 导入中使用 `.js` 扩展名
- 使用 Zod schema 进行所有输入验证
- 使用 Chalk 进行彩色输出
- 使用 @clack/prompts 进行交互式输入
