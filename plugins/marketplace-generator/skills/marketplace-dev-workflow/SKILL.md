---
name: marketplace-dev-workflow
description: 在 marketplace 项目中创建、更新或删除插件时触发。当用户说 "add a new plugin"、"create a plugin for X"、"update the X plugin"、"remove X plugin"，或修改 plugins/ 下的文件时使用。强制执行开发工作流、结构验证和版本管理。
---

# Marketplace 开发工作流

在 marketplace 项目中创建、修改或更新插件时强制执行正确的开发工作流。检测到 `plugins/` 目录更改时自动触发。

## 触发

当以下情况时自动激活：
- 在 `plugins/` 下创建了新的插件目录
- `plugins/` 中的文件被修改
- 用户提及添加、更新或删除插件

## 工作流：新建插件

### 1. 规划

在创建任何文件之前，确认：
- 插件名称（kebab-case）
- 插件描述
- 所需组件（skills、agents、hooks、rules）

### 2. 创建

生成插件结构：
```
plugins/<plugin-name>/
├── .claude-plugin/
│   └── plugin.json
├── skills/          # 如需要
├── agents/          # 如需要
├── hooks/           # 如需要
├── rules/           # 如需要
└── README.md
```

创建插件的 `.claude-plugin/plugin.json`，使用 `git config user.name` 和 `git config user.email` 填充 `author` 字段。

按照官方格式创建插件的 `README.md`：
- 插件名称和一行描述
- `## What It Does` 部分
- `## Usage` 部分
- `## Authors` 部分，包含 git user.name 和 user.email

验证：
- `plugin.json` 具有必需的 `name`、`description`、`author` 字段
- 所有目录遵循命名约定
- 组件文件具有有效 frontmatter

### 3. 注册

更新 `.claude-plugin/marketplace.json`：
- 在 `plugins` 数组中添加插件条目
- 设置正确的相对路径
- 需要时更新 marketplace 版本

更新项目根目录 `README.md`：
- 在包含的插件列表中添加新插件
- 包含插件名称、描述和指向其 README 的链接

更新 `CLAUDE.md`：
- 在 `## Plugins` 部分添加插件条目：`- [<plugin-name>](docs/plugins/<plugin-name>.md) — <description>`

创建 `docs/plugins/<plugin-name>.md`：
- 插件目的和描述
- 列出所有 skills、agents、hooks、rules 的组件表
- 当前版本号

### 4. 验证

使用 **marketplace-validator** agent 运行完整验证清单：
- 插件清单有效性
- marketplace.json 一致性
- 版本号
- CLAUDE.md 引用
- 文档完整性
- 组件结构

## 工作流：更新插件

### 1. 检测更改

识别更改内容：
- 插件清单被修改 → 触发版本升级
- 组件添加/删除 → 验证结构 + 更新插件 README
- 插件描述更改 → 更新 marketplace.json 和插件 README

**更新插件 README** 当组件更改时：
- 在组件列表中添加新组件
- 删除不再存在的组件
- 不列出已删除或废弃的组件

### 2. 版本升级

当插件清单更改时，提议版本变更：
- 小改递增 patch 版本
- 新功能递增 minor 版本
- 破坏性更改递增 major 版本

在应用版本升级前请用户确认。解释提议的更改和理由。

### 3. 级联更新

用户确认版本升级后：
- 更新 `marketplace.json` 版本（任何插件版本更改时都升级）
- 如果 marketplace 描述更改，更新 marketplace.json
- 验证所有插件条目一致

当 marketplace 结构更改时更新项目根目录 `README.md`：
- 在插件列表中添加新插件
- 更新更改的插件描述
- 删除已删除插件的条目

更新 `CLAUDE.md`：
- 在 `## Plugins` 部分添加/删除插件条目
- 更新更改的描述

更新 `docs/plugins/<plugin-name>.md`：
- 更新组件表以反映添加/删除的组件
- 更新版本号

### 4. 验证一致性

使用 **marketplace-validator** agent 确认：
- `plugins/` 中的所有插件都在 `marketplace.json` 中引用
- `marketplace.json` 中的所有条目都存在于 `plugins/` 中
- 无过时或损坏的引用
- 版本号遵循 semver
- CLAUDE.md 引用有效

## 工作流：删除插件

### 1. 确认

请用户确认删除插件。

### 2. 更新

- 删除插件目录
- 从 `marketplace.json` 中删除条目
- 更新 marketplace 版本
- 从项目根目录 `README.md` 插件列表中删除插件
- 从 `CLAUDE.md` `## Plugins` 部分删除插件条目
- 删除 `docs/plugins/<plugin-name>.md`

### 3. 验证

使用 **marketplace-validator** agent 确保无悬空引用且所有检查通过。

## 规则

- 未经用户确认绝不修改插件文件
- 插件更改时始终更新 `marketplace.json`
- 所有插件名称强制执行 kebab-case
- 每次更改后验证插件结构
- marketplace.json 版本与插件版本更改保持同步（任何插件版本更改时都升级）
