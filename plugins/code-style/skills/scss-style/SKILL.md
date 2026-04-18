---
name: "scss-style"
description: "SCSS 命名约定、嵌套限制、变量 tokens 和文件组织风格指南。在编辑 .scss/.sass 文件时触发。"
trigger: "编辑 .scss .sass 文件、SCSS 样式"
argument-hint: "[可选：具体主题如 'naming'、'nesting'、'tokens']"
allowed-tools: ["Read", "Grep", "Glob"]
---

# SCSS 风格

为 AI 生成的代码强制 SCSS 编码约定。

## 何时激活

- 编辑 `.scss`、`.sass` 文件
- 用户调用 `/scss-style`
- 生成 SCSS 样式

## 规则

完整详情参考 [rules/scss/coding-style.md](../../rules/scss/coding-style.md)，包括：

- **命名**：类/变量/mixins 使用 kebab-case
- **嵌套**：最多 3 层，使用 `&` 表示修饰符
- **组织**：Tokens → Mixins → 组件样式
- **变量**：使用 CSS 自定义属性作为设计 tokens
