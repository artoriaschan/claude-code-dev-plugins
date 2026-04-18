# 示例：生成的 `init` 命令

## 从用户收集的输入

| 字段 | 值 |
|-------|-------|
| 命令名称 | `init` |
| 描述 | 初始化新的项目配置 |
| 参数 | 无 |
| 选项 | `--name, -n`（项目名称），`--template, -t`（模板预设） |
| 交互式提示 | 是 |

## 生成的文件：`packages/cli/src/commands/init.ts`

```typescript
import { Command } from 'commander'
import chalk from 'chalk'
import { z } from 'zod'
import { text, select, spinner } from '@clack/prompts'

const schema = z.object({
  name: z.string().min(1, 'Project name is required'),
  template: z.enum(['basic', 'full', 'custom']).default('basic'),
})

export function registerInit(program: Command) {
  const cmd = program
    .command('init')
    .description('Initialize a new project configuration')
    .option('--name <name>, -n <name>', 'Project name')
    .option('--template <type>, -t <type>', 'Template preset', 'basic')

  cmd.action(async (opts) => {
    const projectName = opts.name || await text({
      message: 'Enter project name',
      placeholder: 'my-project',
      validate: (value) => value.length > 0 ? undefined : 'Name is required',
    })

    const template = opts.template || await select({
      message: 'Select a template',
      options: [
        { value: 'basic', label: 'Basic' },
        { value: 'full', label: 'Full' },
        { value: 'custom', label: 'Custom' },
      ],
    })

    const parsed = schema.safeParse({ name: projectName, template })

    if (!parsed.success) {
      console.error(chalk.red('Invalid configuration:'), parsed.error.message)
      process.exit(1)
    }

    const s = spinner()
    s.start('Initializing project...')
    s.stop('Project initialized successfully')
    console.log(chalk.green(`Created ${projectName} with ${template} template`))
  })
}
```

## Barrel 导出：`packages/cli/src/commands/index.ts`

```typescript
export { registerInit } from './init.js'
```

## 测试存根：`packages/cli/tests/init.spec.ts`

```typescript
import { describe, it, expect } from 'vitest'
import { Command } from 'commander'
import { registerInit } from '../src/commands/init.js'

describe('init', () => {
  it('should register without error', () => {
    const program = new Command()
    registerInit(program)
    expect(program.commands).toHaveProperty('init')
  })
})
```
