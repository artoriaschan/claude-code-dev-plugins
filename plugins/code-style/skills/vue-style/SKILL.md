---
name: "vue-style"
description: "Vue composition API、组件模式、props/emits 类型定义和错误处理风格指南。在编辑 .vue 文件时触发。"
trigger: "编辑 .vue 文件、Vue 组件"
argument-hint: "[可选：具体主题如 'composables'、'props'、'error-handling']"
allowed-tools: ["Read", "Grep", "Glob"]
---

# Vue 风格

为 AI 生成的代码强制 Vue 编码约定。

## 何时激活

- 编辑 `.vue` 文件
- 用户调用 `/vue-style`
- 生成 Vue组件

## 规则

完整详情参考 [rules/vue/coding-style.md](../../rules/vue/coding-style.md)，包括：

- **Composition API**：始终使用 `<script setup lang="ts">`
- **Props/Emits**：类型安全使用 `defineProps<Interface>()` 和 `defineEmits<Interface>()`
- **命名**：组件 PascalCase、事件 kebab-case、composables 使用 `use` 前缀
- **Error Boundary**：`app.config.errorHandler` 或 `onErrorCaptured`
