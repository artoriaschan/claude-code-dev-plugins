---
name: cli-create
description: 当用户请求从头创建新的 TypeScript CLI 项目时激活。触发词："create a CLI tool"、"scaffold a CLI project"、"new CLI monorepo"、"bootstrap TypeScript CLI"。生成基于 pnpm 的项目，包含 Commander、Zod、Chalk 和完整工具链。
---

# CLI 项目创建器

## 目的

通过交互式用户提示生成完整的 TypeScript CLI 项目脚手架。支持 monorepo（pnpm workspace + Turborepo）和 simple（单包）两种结构。核心栈：Commander、Zod、Chalk 5.x、tsup、Vitest、@clack/prompts、ESLint、Prettier、Husky 和 Changesets。

## 触发条件

当用户请求创建新的 CLI 工具、脚手架化 CLI 项目或生成命令行应用样板代码时激活。

## 工作流

### 步骤 1：收集项目配置

通过交互式问卷收集以下必填字段：

| 字段 | 描述 | 示例 |
|------|------|------|
| `projectName` | 包名（kebab-case） | `my-tool` |
| `description` | 项目简短描述 | `A tool for managing X` |
| `binName` | CLI 命令名称 | `my-tool` |
| `projectType` | 项目结构 — `monorepo` 或 `simple` | `simple`（推荐） |
| `commands` | 要创建的子命令列表 | `["init", "list", "run"]` |
| `authorName` | 作者名称 | `artorias` |

对于列表中的每个命令，还需收集：
- 命令名称（kebab-case）
- 命令描述
- 是否接受参数（是/否）
- 是否有选项/标志（是/否）

### 步骤 2：生成项目脚手架

根据 `projectType` 生成项目结构：

#### Monorepo（`projectType: "monorepo"`）

```
project-root/
├── .claude-plugin/
│   └── plugin.json
├── .github/
│   └── workflows/
│       └── ci.yml
├── .husky/
│   └── pre-commit
├── packages/
│   ├── cli/
│   │   ├── schemas/
│   │   ├── scripts/
│   │   │   └── generate-schemas.ts
│   │   └── src/
│   │       ├── core/
│   │       │   ├── config.ts
│   │       │   └── types.ts
│   │       ├── commands/
│   │       │   └── <command>.ts   （每个用户指定的命令一个文件）
│   │       └── index.ts
│   └── widget-renderer/
│       └── src/
│           └── index.ts
├── .gitignore
├── .npmrc
├── eslint.config.js
├── package.json
├── pnpm-workspace.yaml
├── sheriff.config.ts
├── tsconfig.base.json
├── turbo.json
├── vitest.config.ts
└── vitest.workspace.ts
```

#### Simple（`projectType: "simple"`）

```
project-root/
├── .claude-plugin/
│   └── plugin.json
├── .github/
│   └── workflows/
│       └── ci.yml
├── .husky/
│   └── pre-commit
├── src/
│   ├── core/
│   │   ├── config.ts
│   │   └── types.ts
│   ├── commands/
│   │   └── <command>.ts   （每个用户指定的命令一个文件）
│   └── index.ts
├── tests/
│   └── <command>.spec.ts
├── .gitignore
├── .npmrc
├── eslint.config.js
├── package.json
├── tsconfig.json
├── vitest.config.ts
└── tsup.config.ts
```

### 步骤 3：应用代码规范

所有生成的代码必须遵循 `references/tech-stack.md` 中的约定：

- 仅使用 TypeScript ESM（`"type": "module"`）
- 通过 Sheriff 强制执行 barrel exports
- `.spec.ts` 测试命名
- 启用 TypeScript 严格模式
- 目录约定：`domain/` `core/` `feature/`
- Zod 用于模式验证
- Commander 用于 CLI 命令
- Chalk 5.x 用于终端颜色
- @clack/prompts 用于交互式提示
- Vitest 用于测试
- Changesets 用于版本管理（fixed 模式）

### 步骤 4：生成命令模板

为每个用户指定的命令创建命令文件：
- **Monorepo：** `packages/cli/src/commands/<command>.ts`
- **Simple：** `src/commands/<command>.ts`

遵循 `references/command-template.md` 中的模板结构（来自 cli-add-command skill 的 `../cli-add-command/references/command-template.md`）。

每个命令文件包含：
1. Commander 命令定义，含 `.command()`、`.description()`、`.argument()`、`.option()`、`.action()`
2. Zod 模式用于输入验证
3. Chalk 彩色输出
4. 从 barrel 文件导出（`src/index.ts` 或 `packages/cli/src/index.ts`）

### 步骤 5：配置工具链

根据 `projectType` 生成配置文件：

**两种类型通用：**
- `package.json` — 项目配置和脚本（build、dev、test、lint、format、release）
- `tsconfig.json`（monorepo 为 `tsconfig.base.json`）— TypeScript 配置（ESM、严格模式、moduleResolution: "NodeNext"）
- `vitest.config.ts` — 测试配置
- `eslint.config.ts` — lint 检查
- `.husky/pre-commit` — lint-staged 钩子

**仅 Monorepo：**
- `pnpm-workspace.yaml` — workspace 定义
- `turbo.json` — 构建编排
- `sheriff.config.ts` — 模块边界规则
- `vitest.workspace.ts` — workspace 测试配置

### 步骤 6：验证和报告

生成后验证：
- 所有文件已正确创建
- `pnpm install` 运行无错误
- `pnpm build` 完成
- `pnpm test:run` 通过（初始空测试）

向用户报告生成的结构和后续步骤。

## 附加资源

### 参考文件

- **`references/tech-stack.md`** — 完整的技术栈详情、版本约束和代码规范
- **`references/scaffold-structure.md`** — 详细的项目结构说明和文件模板
- **`../cli-add-command/references/command-template.md`** — cli-create 和 cli-add-command 共用的命令文件模板

### 示例

- **`examples/generated-project.md`** — 完整生成项目的输出示例
