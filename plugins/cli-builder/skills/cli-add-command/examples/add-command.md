# 示例：生成的带参数和选项的 `add` 命令

## 从用户收集的输入

| 字段 | 值 |
|-------|-------|
| 命令名称 | `add` |
| 描述 | 向项目添加新资源 |
| 参数 | `name`（资源名称），`type`（资源类型） |
| 选项 | `--dry-run`（仅预览），`--output`（输出目录） |
| 交互式提示 | 否 |

## 生成的文件：`packages/cli/src/commands/add.ts`

```typescript
import { Command } from 'commander'
import chalk from 'chalk'
import { z } from 'zod'

const schema = z.object({
  dryRun: z.boolean().default(false),
  output: z.string().default('./resources'),
})

export function registerAdd(program: Command) {
  const cmd = program
    .command('add <name> <type>')
    .description('Add a new resource to the project')
    .option('--dry-run', 'Preview changes without applying them', false)
    .option('--output <dir>', 'Output directory', './resources')

  cmd.action(async (name, type, opts) => {
    const parsed = schema.safeParse(opts)

    if (!parsed.success) {
      console.error(chalk.red('Invalid options:'), parsed.error.message)
      process.exit(1)
    }

    if (parsed.data.dryRun) {
      console.log(chalk.yellow('[dry-run] Would create:'))
      console.log(chalk.yellow(`  ${parsed.data.output}/${name}.${type}`))
      return
    }

    console.log(chalk.green(`Added ${name} (${type}) to ${parsed.data.output}`))
  })
}
```

## Barrel 导出：`packages/cli/src/commands/index.ts`

```typescript
export { registerAdd } from './add.js'
```

## 测试存根：`packages/cli/tests/add.spec.ts`

```typescript
import { describe, it, expect } from 'vitest'
import { Command } from 'commander'
import { registerAdd } from '../src/commands/add.js'

describe('add', () => {
  it('should register without error', () => {
    const program = new Command()
    registerAdd(program)
    expect(program.commands).toHaveProperty('add')
  })

  it('should accept two positional arguments', () => {
    const program = new Command()
    registerAdd(program)
    const cmd = program.commands.find((c) => c.name() === 'add')
    expect(cmd).toBeDefined()
  })
})
```
