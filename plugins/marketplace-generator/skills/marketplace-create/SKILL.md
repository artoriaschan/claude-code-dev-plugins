---
name: marketplace-create
description: 在从头创建新的 Claude Code 插件 marketplace 项目时使用此技能。触发条件："create a plugin marketplace"、"set up a new marketplace"、"scaffold a plugin marketplace"、"build a Claude Code plugin collection"。引导完成需求收集、项目生成、文档和验证。
---

# Marketplace 创建

引导用户创建完整的 Claude Code 插件 marketplace 项目。分为四个阶段：收集、生成、文档、验证。

## 触发

当用户要求创建新的插件 marketplace 项目，或提及"create marketplace"、"new marketplace"或"plugin market"时自动激活。

## 阶段 1：收集

逐个提问以收集需求：

### 1. Marketplace 名称
询问用户 marketplace 项目名称（kebab-case）。如果用户不确定，建议一个描述性名称。

### 2. Marketplace 描述
询问 marketplace 的用途。帮助用户编写清晰、简洁的描述。

### 3. 插件规划
询问用户想在 marketplace 中包含哪些插件。引导用户：
- 需要多少个插件？
- 每个插件的用途是什么？
- 每个插件应该有哪些组件（skills、agents、hooks、rules）？

如果用户不确定，建议一个合理的默认集合。

## 阶段 2：生成

收集完所有信息后，生成项目。使用 `references/` 目录中的模板。

### 目录结构
```bash
mkdir -p <marketplace-name>/.claude-plugin
mkdir -p <marketplace-name>/plugins
mkdir -p <marketplace-name>/docs/plugins
```

### 插件清单
为每个规划的插件创建：
```bash
mkdir -p <marketplace-name>/plugins/<plugin-name>/.claude-plugin
```

使用 `references/plugin-manifest.md` 模板创建清单。运行 `git config user.name` 和 `git config user.email` 来填充 `author` 字段。

### 插件 README
使用 `references/plugin-readme.md` 模板为每个插件创建 `README.md`。运行 `git config user.name` 和 `git config user.email` 来填充 `## Authors` 部分。

### marketplace.json
使用 `references/marketplace-json.md` 模板创建 `.claude-plugin/marketplace.json`。运行 `git config user.name` 和 `git config user.email` 来填充 `owner` 字段。

### 示例插件
将此插件的 `templates/example-plugin/` 目录下的内置示例插件复制到 `<marketplace-name>/plugins/example-plugin/`。

## 阶段 3：文档

生成所有文档。使用 `references/` 目录中的模板。

### CLAUDE.md
使用 `references/claude-md.md` 模板创建 `<marketplace-name>/CLAUDE.md`。为每个插件添加一行链接：`- [<plugin-name>](docs/plugins/<plugin-name>.md) — <description>`

### docs/project-structure.md
使用 `references/project-structure.md` 模板创建 `<marketplace-name>/docs/project-structure.md`。将 `<marketplace-name>` 替换为实际值。

### docs/plugins/<plugin-name>.md
为每个插件（包括 example-plugin），使用 `references/plugin-doc.md` 模板创建 `<marketplace-name>/docs/plugins/<plugin-name>.md`。仅包含该插件实际存在的组件行。

### README.md
创建 `<marketplace-name>/README.md`，包含：
- Marketplace 名称和描述
- 包含的插件列表（链接到 `docs/plugins/`）
- 安装说明（`marketplace add`）
- 快速入门指南
- 链接到 `docs/project-structure.md` 查看项目布局

## 阶段 4：验证

使用 **marketplace-validator** agent 验证完整项目。确保：
- `plugins/` 中的每个插件都有有效的 `.claude-plugin/plugin.json`，且 `author` 字段已填充
- `plugins/` 中的所有插件都在 `marketplace.json` 中引用
- `marketplace.json` 中的所有条目都存在于 `plugins/` 中
- `marketplace.json` 具有正确的相对路径且 `owner` 字段已填充
- `CLAUDE.md` 引用正确的文档文件路径
- `docs/plugins/` 中有 `plugins/` 中每个插件对应的文件
- README 中的插件列表与 `plugins/` 目录匹配
- 所有插件 README 的 `## Authors` 部分已填充

## 规则

- 阶段 1（收集）期间逐个提问
- 绝不跳过阶段 1 — 生成前始终先收集需求
- 验证所有插件名称为 kebab-case
- 确保每个插件都有有效的 `.claude-plugin/plugin.json`
- 从此插件的 `templates/example-plugin/` 复制示例插件
