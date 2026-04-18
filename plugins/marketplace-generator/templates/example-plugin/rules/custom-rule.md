---
name: custom-rule-example
description: 演示插件 kebab-case 命名约定的示例规则
---

# Custom Rule Example

这是一个示例规则，演示如何为 marketplace 插件定义自定义编码约定。

## Purpose

规则定义 Claude Code 在此 marketplace 项目中处理插件时的行为约束。

## Example Rule

### Naming Convention

所有插件名称必须使用 kebab-case 格式：

- Good: `code-review`、`test-runner`、`api-docs`
- Bad: `codeReview`、`test_runner`、`APIdocs`

### When This Rule Applies

- 创建新插件时
- 修改现有插件清单时
- 更新 marketplace.json 插件引用时

此规则是 example-plugin 模板的一部分，展示如何向 marketplace 插件添加自定义规则。
