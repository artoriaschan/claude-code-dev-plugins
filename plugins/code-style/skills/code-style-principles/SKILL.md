---
name: "code-style-principles"
description: "在生成或修改代码时强制执行个人编码风格约定。在任何 TypeScript、React、Vue 或 SCSS 代码更改时激活。"
trigger: "编写或修改 TypeScript、React、Vue 或 SCSS 代码"
allowed-tools: ["Read", "Grep", "Glob"]
---

# 编码风格原则

在编写或修改代码时激活。详细规则参考 `rules/` 目录 — 此技能提供快速参考和触发器。

## 快速参考

### 命名
| 元素 | 约定 | 示例 |
|---------|-----------|---------|
| 变量/函数 | `camelCase` | `fetchUserProfile` |
| 组件 | `PascalCase` | `UserProfile` |
| 常量 | `UPPER_SNAKE_CASE` | `MAX_RETRY_COUNT` |
| 布尔值 | `is`/`has`/`should` 前缀 | `isVisible`、`hasPermission` |
| 事件回调 | `handle`/`on` 前缀 | `handleClick`、`onSubmit` |
| 文件/文件夹 | `kebab-case` | `user-profile.ts` |

### 导入顺序
1. 核心框架（react、vue）
2. 第三方库（lodash、axios）
3. 内部模块（由近及远）
4. 类型导入
5. CSS/SCSS

### 文件组织
- 按类型组织：`components/`、`hooks/`、`utils/`、`types/`
- 工具函数按功能拆分：`utils/string-utils.ts`
- 每个文件最多 800 行，每个函数最多 50 行

### 错误处理
- 优先使用顶层统一处理
- Web 项目：原生 `Error`；CLI/工具：自定义 `AppError`
- 错误消息：具体、可操作、不包含敏感信息
- React/Vue：必须使用 Error Boundary

## 详细规则

有关包含示例的完整规则，参考以下文件：

- **通用**：`rules/common/coding-style.md` — 命名、不可变性、注释、错误处理
- **TypeScript**：`rules/typescript/coding-style.md` — 类型、导入、文件结构
- **React**：`rules/react/coding-style.md` — 组件、hooks、error boundaries
- **Vue**：`rules/vue/coding-style.md` — Composition API、props/emits
- **SCSS**：`rules/scss/coding-style.md` — 命名、嵌套、tokens
- **模式**：`rules/common/patterns.md`、`rules/typescript/patterns.md`、`rules/react/patterns.md`、`rules/vue/patterns.md`
- **测试**：`rules/common/testing.md`
- **Git 提交**：`rules/common/git-commit.md`
