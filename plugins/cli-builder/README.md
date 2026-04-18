# cli-builder

Claude Code CLI 工具构建插件 — 遵循现代 ESM 约定的 TypeScript CLI 项目脚手架和命令模板生成。

## 功能

提供两个用于构建 TypeScript CLI 项目的技能：
- `cli-create` — 交互式项目创建，包含 pnpm workspace、Commander、Zod、Chalk 和完整工具链（ESLint、Sheriff、Prettier、Husky、Changesets）
- `cli-add-command` — 生成命令文件，包含 Commander 定义、Zod 验证模式、Chalk 输出和 barrel exports

**简洁模式**：使用 `simple: true` 标志跳过复杂工具链（ESLint、Sheriff、Changesets），生成轻量级项目。

## 使用

触发短语：
- "create a CLI"、"scaffold a CLI project" — 生成完整的 monorepo 项目
- "add a command"、"create a new CLI command" — 生成命令模板文件

## 组件

| 类型 | 名称 | 用途 |
|------|------|------|
| Skill | `cli-create` | TypeScript 交互式 CLI 项目创建 |
| Skill | `cli-add-command` | 生成命令模板文件 |

## 技术栈

生成项目使用：
- TypeScript ESM + Commander + Zod + Chalk 5.x + tsup + Vitest + @clack/prompts
- pnpm workspace + ESLint + Sheriff + Prettier + Husky + Changesets

## 作者

artoriaschan (dalecracker@gmail.com)
