# Claude Code 插件管理

## 项目目的

本项目管理 Claude Code 插件，用于个人开发工作流。`plugins/` 下的每个插件都独立维护，拥有自己的清单文件和组件。

**仓库地址：** https://github.com/artoriaschan/claude-code-dev-plugins

## 快速导航

| 任务 | 参考文档 |
|------|----------|
| 项目简介和背景 | `docs/project-overview.md` |
| 插件目录布局和清单格式 | `docs/plugin-structure.md` |
| 如何开发插件 | `docs/development-workflow.md` |

## 活跃插件

| 插件 | 组件 | 用途 |
|------|------|------|
| `cli-builder` | 2 个 skills | TypeScript CLI 项目脚手架（含简洁模式）和命令模板生成 |
| `code-style` | 5 个 skills, 1 个 agent, 11 个 rules | 为 AI 生成代码强制执行个人编码风格规范 |
| `marketplace-generator` | 3 个 skills, 1 个 agent | 生成完整的 Claude Code 插件市场项目，含引导式工作流和格式化现有项目 |

## 核心约定

- 每个插件拥有独立的 `.claude-plugin/plugin.json` 清单文件
- 插件文件位于 `plugins/<name>/` — 自包含且可独立部署
- Skills 和 agents 从标准目录自动发现
- 代码规范使用现代 TypeScript 模式（ESM、严格模式）
