# 技术栈与代码约定

构建现代 TypeScript CLI 应用程序的行业标准约定。所有生成的 CLI 项目必须遵循这些约定。

## 核心技术

| 技术 | 版本 | 用途 | 理由 |
|------------|---------|---------|-----------|
| Node.js | >=18.0.0（推荐 20.x LTS） | 运行时 | LTS 稳定性、原生 ESM 支持 |
| TypeScript | 5.4.x+ | 语言 | 严格类型检查、现代 ESM 支持 |
| pnpm | 9.x+ | 包管理器 | 快速安装、严格的 peer deps |
| Commander | 13.x | CLI 框架 | 成熟、轻量级、出色的 TS 支持、自动生成帮助 |
| Chalk | 5.x | ANSI 颜色 | 仅 ESM、最小开销、链式 API |
| Zod | 3.24.x | Schema 验证 | TypeScript 优先、运行时验证、优秀的错误信息 |

## 基础设施

| 技术 | 版本 | 用途 |
|------------|---------|---------|
| tsup | 8.x | 打包器 — 零配置 TypeScript 打包、ESM 输出 |
| tsx | 4.x | TypeScript 执行 — 开发时直接运行 TS、ESM 原生支持 |
| Changesets | 2.x | 版本管理 — fixed 模式（monorepo）/ normal 模式（简单） |
| Vitest | 3.x+ | 测试 — ESM 原生支持、TypeScript 优先、比 Jest 更快 |

### 仅 Monorepo 基础设施

| 技术 | 版本 | 用途 |
|------------|---------|---------|
| Turborepo | 2.x | 带缓存的构建编排 |

## 辅助库

| 库 | 版本 | 用途 |
|---------|---------|---------|
| @clack/prompts | 0.10.x | 交互式提示 — 现代、美观、轻量 |

## 开发工具

| 工具 | 用途 | 范围 |
|------|---------|-------|
| ESLint 10.x + typescript-eslint | 带类型检查的 Linting | 两者 |
| Prettier 3.x | 代码格式化 | 两者 |
| Turborepo 2.x | 带缓存的构建编排 | 仅 monorepo |
| Sheriff 0.19.x | 模块边界强制检查 | 仅 monorepo |
| Husky 9.x + lint-staged 16.x | Git 钩子用于提交前检查 | 两者 |

## 不应使用的技术

| 避免使用 | 原因 | 替代方案 |
|-------|-----|-------------|
| ts-node | 比 tsx 慢、默认 CommonJS | tsx (4.x) |
| Jest | CommonJS 优先、慢、ESM 支持复杂 | Vitest (3.x) |
| Inquirer.js | 包体积大、API 过时 | @clack/prompts |
| npm/yarn workspaces | 安装慢、依赖约束不严格 | pnpm workspaces |
| chalk 4.x | CommonJS、项目要求仅 ESM | chalk 5.x |
| oclif | 对于简单 CLI 过于复杂、包体积大 | Commander |
| Joi | 包体积大、默认 CommonJS、TS 原生支持较弱 | Zod |

## 项目约定

- 仅 TypeScript ESM（`"type": "module"`）
- Barrel 导出（简单项目：`src/index.ts`，monorepo：`packages/cli/src/index.ts`）
- 测试使用 `.spec.ts` 命名约定
- 启用 TypeScript 严格模式

## 目录约定

- `core/` — 共享工具函数、配置、类型
- `commands/`（或 `feature/`） — 命令实现
- `domain/` — 业务逻辑和核心类型

## package.json Scripts 模板

### Monorepo

```json
{
  "scripts": {
    "prepare": "husky",
    "build": "turbo build",
    "dev": "turbo dev",
    "test": "vitest",
    "test:run": "vitest --run",
    "test:coverage": "vitest --coverage",
    "lint": "pnpm lint:eslint && pnpm lint:sheriff",
    "lint:eslint": "eslint packages/*/src/**/*.ts",
    "lint:sheriff": "sheriff verify",
    "format": "prettier --write .",
    "format:check": "prettier --check .",
    "changeset": "changeset",
    "version": "changeset version",
    "release": "pnpm build && changeset publish"
  }
}
```

### 简单项目

```json
{
  "scripts": {
    "prepare": "husky",
    "build": "tsup src/index.ts --format esm --dts --clean",
    "dev": "tsx src/index.ts",
    "test": "vitest",
    "test:run": "vitest --run",
    "test:coverage": "vitest --coverage",
    "lint": "eslint src/**/*.ts",
    "format": "prettier --write .",
    "format:check": "prettier --check .",
    "changeset": "changeset",
    "version": "changeset version",
    "release": "pnpm build && changeset publish"
  }
}
```

## tsconfig.base.json 模板

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "lib": ["ES2022"],
    "strict": true,
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "skipLibCheck": true
  }
}
```
