# 脚手架结构参考

## Monorepo 概览

生成的项目是一个使用 pnpm 和 Turborepo 编排的 monorepo。所有包通过 Changesets fixed 模式共享统一版本。

## 根文件

### package.json（根目录）

- `private: true` — 防止意外发布
- `type: "module"` — 仅 ESM
- `packageManager` 字段指定 pnpm 版本
- `engines.node` >= 18.0.0
- 开发依赖：typescript、tsup、vitest、eslint、prettier、husky、lint-staged、changesets、turbo、sheriff

### pnpm-workspace.yaml

```yaml
packages:
  - 'packages/*'
```

### tsconfig.base.json

所有包共享的基础配置。ESM 设置、严格模式、NodeNext 解析。

### turbo.json

带缓存的构建编排。定义任务依赖（build 依赖 ^build，test 依赖 build）。

### vitest.config.ts + vitest.workspace.ts

根级 vitest 配置。workspace 引用所有包。覆盖率使用 @vitest/coverage-v8。

### eslint.config.js

Flat 配置，包含 typescript-eslint、sheriff、prettier。导入和 barrel 导出规则。

### sheriff.config.ts

模块边界强制检查。定义包之间允许的导入。

### .husky/pre-commit

在提交前运行 lint-staged。

### .gitignore

```
node_modules/
dist/
types/
*.local.*
.claude/
```

## 包结构

`packages/` 中的每个包遵循以下结构：

```
packages/<name>/
├── package.json        # 包级配置
├── tsconfig.json       # 继承根 tsconfig.base.json
├── tsconfig.build.json # 构建专用配置
├── src/
│   ├── index.ts        # Barrel 导出
│   ├── core/           # 共享工具函数
│   └── commands/       # 命令实现
└── tests/              # 测试文件 (*.spec.ts)
```

### CLI 包（packages/cli）

主 CLI 包。包含：

- `package.json` 中 `bin` 字段指向 dist 入口
- `src/index.ts` — 引导文件，注册 Commander 程序
- `src/commands/` — 每个子命令一个文件
- `src/core/` — 配置加载、类型、工具函数
- `scripts/generate-schemas.ts` — 从 Zod 生成 JSON schema

### Widget-Renderer 包（packages/widget-renderer）

共享渲染库。包含：

- `src/index.ts` — barrel 导出 widget 类型和渲染器
- 配置 schema 导出

### Usage Adapter 包（可选）

外部 API 适配器。使用动态导入模式。

## 文件模板

### 命令模板

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
      // 实现
    })
}
```

### Barrel 导出模板

```typescript
export { registerInit } from './commands/init.js'
export { registerList } from './commands/list.js'
```

### 配置模板

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
