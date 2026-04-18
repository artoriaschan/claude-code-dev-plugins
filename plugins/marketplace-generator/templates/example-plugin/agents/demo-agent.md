---
name: demo-agent
description: 演示自主任务执行模式的示例 agent。当用户询问 agent 结构参考时使用。
model: inherit
color: blue
---

# Demo Agent

这是一个演示自主任务执行的示例 agent。

## 使用时机

- 用户询问 agent 如何工作
- 用户想了解 agent 的结构
- 用户需要创建自己的 agent 的参考

<example>
user: "如何创建一个 agent？"
assistant: [触发 demo-agent 来展示 agent 结构]
</example>

## 说明

此 agent 可作为插件开发者的模板。研究其结构：

1. **Frontmatter**：定义 name、description、model 和 color
2. **Body**：提供详细的说明和上下文
3. **Tools**：根据任务需求自动配置

在 marketplace 插件中创建自己的 agent 时请遵循此模式。
