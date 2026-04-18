# 生成项目示例

此文件展示了一个完整的生成项目示例 — "coding-status" CLI。

## 用户输入

```
projectName: coding-status
description: Cloud provider usage statusline for Claude Code CLI
binName: coding-status
commands:
  - name: init
    description: Initialize configuration
    arguments: no
    options: no
  - name: add
    description: Add a new provider
    arguments: no
    options: no
  - name: list
    description: List all providers
    arguments: no
    options: no
  - name: statusline
    description: Output statusline string
    arguments: no
    options: no
authorName: artorias
```

## 生成的结构

```
coding-status/
├── .claude-plugin/
│   └── plugin.json
├── .husky/
│   └── pre-commit
├── packages/
│   ├── cli/
│   │   ├── src/
│   │   │   ├── core/
│   │   │   │   ├── config.ts
│   │   │   │   └── types.ts
│   │   │   ├── commands/
│   │   │   │   ├── init.ts
│   │   │   │   ├── add.ts
│   │   │   │   ├── list.ts
│   │   │   │   └── statusline.ts
│   │   │   └── index.ts
│   │   ├── package.json
│   │   └── tsconfig.json
│   └── widget-renderer/
│       ├── src/
│       │   └── index.ts
│       ├── package.json
│       └── tsconfig.json
├── package.json
├── pnpm-workspace.yaml
├── tsconfig.base.json
├── turbo.json
├── vitest.config.ts
├── vitest.workspace.ts
├── eslint.config.js
├── sheriff.config.ts
└── .gitignore
```

## 命令示例（src/commands/init.ts）

```typescript
import { Command } from 'commander'
import chalk from 'chalk'
import { intro, outro, text } from '@clack/prompts'

export function registerInit(program: Command) {
  program
    .command('init')
    .description('Initialize coding-status configuration')
    .action(async () => {
      intro(chalk.green('Initializing coding-status'))

      const configPath = await text({
        message: 'Config directory path',
        initialValue: '~/.coding-status',
      })

      outro(chalk.green('Configuration initialized'))
    })
}
```
