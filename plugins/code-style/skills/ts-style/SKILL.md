---
description: "TypeScript 风格指南。在编辑 .ts/.js/.tsx/.jsx 文件时触发。"
trigger: "编辑 .ts .tsx .js .jsx 文件"
argument-hint: "[可选：具体主题如 'types'、'imports'、'error-handling']"
allowed-tools: ["Read", "Grep", "Glob"]
---

# TypeScript 风格

为 AI 生成的代码强制 TypeScript 编码约定。

## 何时激活

- 编辑 `.ts`、`.tsx`、`.js`、`.jsx` 文件
- 用户调用 `/ts-style`
- 生成新的 TypeScript 代码

## 规则

完整详情参考 [rules/typescript/coding-style.md](../../rules/typescript/coding-style.md)，包括：

- **导入顺序**：核心框架 → 第三方库 → 内部模块 → 类型 → CSS/SCSS
- **类型**：导出函数使用显式类型、形状使用 `interface`、联合类型使用 `type`、避免 `any`
- **文件结构**：按类型拆分（`components/`、`hooks/`、`utils/`、`types/`）
- **错误处理**：顶层统一处理、Web 项目使用原生 `Error`、CLI 使用自定义错误
- **不可变性**：使用展开运算符进行更新
