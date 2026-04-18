---
name: "react-style"
description: "React 组件模式、hooks 使用、error boundaries 和 props 类型风格指南。在编辑 .tsx/.jsx 文件时触发。"
trigger: "编辑 .tsx .jsx 文件、React 组件"
argument-hint: "[可选：具体主题如 'hooks'、'error-boundary'、'props']"
allowed-tools: ["Read", "Grep", "Glob"]
---

# React 风格

为 AI 生成的代码强制 React 编码约定。

## 何时激活

- 编辑 `.tsx`、`.jsx` 文件
- 用户调用 `/react-style`
- 生成 React 组件

## 规则

完整详情参考 [rules/react/coding-style.md](../../rules/react/coding-style.md)，包括：

- **组件结构**：拆分组件逻辑、样式、工具函数
- **Hooks**：`use` 前缀、单一关注点、仅顶层使用
- **Props**：使用 `interface` 类型定义、除非必要不使用 `React.FC`
- **Error Boundary**：所有 React 应用必须配置
