---
name: marketplace-format
description: 扫描现有的插件 marketplace 项目进行 28 项格式和一致性检查（清单验证、交叉引用、文档、组件结构），并批量修复所有问题。当用户说 "format marketplace"、"fix plugin structure"、"standardize plugins"、"check marketplace format"，或要求审计或修复 marketplace 项目时使用。
---

# Marketplace 格式

扫描现有的插件 marketplace 项目，诊断所有格式不一致之处，并批量修复以匹配推荐结构。

## 与 marketplace-validator 的关系

此技能和 **marketplace-validator** agent 共享相同的诊断标准。区别在于：
- **marketplace-format**（此技能）：扫描 + 诊断 + 批量修复。用于需要修复项目时。
- **marketplace-validator**：只读审计。用于验证项目已正确时。

此技能的第 5 阶段会委托给 validator agent 进行最终验证。

## 工作流

### 阶段 1：扫描

1. 定位项目根目录（包含 `.claude-plugin/marketplace.json` 的目录）
2. 读取 `.claude-plugin/marketplace.json` — 提取所有插件条目
3. 读取项目根目录的 `CLAUDE.md`
4. 读取项目根目录的 `README.md`（如果存在）
5. 对于 `marketplace.json.plugins` 中的每个插件，扫描其目录结构
6. 检查 `docs/project-structure.md` 和 `docs/plugins/`（如果存在）
7. 运行 `git config user.name` 和 `git config user.email` 获取作者默认值

### 阶段 2：诊断

运行 `references/diagnosis-checklist.md` 中的所有 28 项检查。生成按类别（A-E）分组的报告：

- A：项目级（6 项检查）
- B：插件级（6 项检查）
- C：交叉引用一致性（5 项检查）
- D：文档完整性（5 项检查）
- E：组件结构（6 项检查）

### 阶段 3：确认

向用户展示按类别分组的诊断报告。简要显示 PASS 项目，对 FAIL 项目提供具体修复说明。在应用修复前请用户确认。

### 阶段 4：修复

应用所有确认的修复：

**项目级：** 添加缺失的 `owner.email`、修复无效的 `plugins[].source` 路径

**插件级：** 创建缺失的 `plugin.json`（使用 `marketplace-create/references/plugin-manifest.md` 模板）、添加缺失的 `author.name` + `author.email`、将目录名称规范化为 kebab-case

**交叉引用：** 在 `marketplace.json` 和 `plugins/` 之间同步未注册/过时的插件、更新 `CLAUDE.md` 和 `README.md` 插件列表

**文档：** 生成缺失的 `docs/project-structure.md`（使用 `marketplace-create/references/project-structure.md`）、创建缺失的 `docs/plugins/<plugin-name>.md`（使用 `marketplace-create/references/plugin-doc.md`）、将插件 `README.md` 重写为官方格式（使用 `marketplace-create/references/plugin-readme.md`）

**组件：** 从 skill frontmatter 中移除 `version`、为 agent frontmatter 添加缺失的 `model` + `color`、修复 rules 的 kebab-case 命名

### 阶段 5：验证

使用 **marketplace-validator** agent 运行完整验证清单。报告最终 PASS/FAIL 结果。

## 规则

- 未经用户确认绝不应用修复
- 始终使用 git config 值作为 author/owner 字段
- 生成缺失文件时保留现有内容 — 仅添加缺失的部分
- 重写 README 时保留现有 What It Does 内容，仅重新格式化结构
- 模板共享自 `marketplace-create/references/` 目录 — 两个技能使用同一数据源
