# marketplace-generator

生成完整的 Claude Code 插件市场项目，包含引导式工作流和示例插件。

## 功能

提供三个技能和一个代理，用于管理 Claude Code 插件市场：
- `marketplace-create` — 引导用户从零开始创建完整的市场项目（收集、生成、文档、验证四个阶段）
- `marketplace-dev-workflow` — 在添加、更新或移除插件时强制执行开发工作流标准
- `marketplace-format` — 扫描、诊断并批量修复现有市场项目中的格式不一致问题
- `marketplace-validator` 代理 — 验证市场结构和一致性

## 使用

触发短语：
- "create a plugin marketplace"、"set up a new marketplace" — marketplace-create
- "add a new plugin"、"update the X plugin" — marketplace-dev-workflow
- "format marketplace"、"fix plugin structure" — marketplace-format

## 组件

| 类型 | 名称 | 用途 |
|------|------|------|
| Skill | `marketplace-create` | 引导用户从零创建完整的市场项目 |
| Skill | `marketplace-dev-workflow` | 添加、更新或移除插件时强制执行开发工作流 |
| Skill | `marketplace-format` | 扫描、诊断并批量修复现有项目的格式不一致 |
| Agent | `marketplace-validator` | 验证市场结构和一致性 |

## 作者

artoriaschan (dalecracker@gmail.com)
