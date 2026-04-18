# 诊断清单

运行以下所有检查。按类别（A-E）分组发现。每项报告为 PASS 或 FAIL，并附带具体文件路径和修复说明。

## A. 项目级（6 项检查）

1. `.claude-plugin/marketplace.json` 存在且为有效 JSON
2. `marketplace.json.name` 存在且非空
3. `marketplace.json.description` 存在且非空
4. `marketplace.json.owner` 同时具有 `name` 和 `email` 字段
5. `marketplace.json.plugins` 数组存在
6. 每个 `plugins[].source` 以 `./plugins/` 开头且目录存在于磁盘上

## B. 插件级（6 项检查）

7. 每个插件目录都有 `.claude-plugin/plugin.json`
8. `plugin.json.name` 使用 kebab-case
9. `plugin.json.version` 遵循 semver（MAJOR.MINOR.PATCH）
10. `plugin.json.description` 非空
11. `plugin.json.author` 同时具有 `name` 和 `email` 字段
12. 插件目录名称与 `plugin.json.name` 匹配

## C. 交叉引用一致性（5 项检查）

13. `marketplace.json.plugins` 中的每个条目都存在于 `plugins/` 目录中
14. `plugins/` 的每个子目录都在 `marketplace.json.plugins` 中注册
15. `CLAUDE.md` 存在于项目根目录且包含 Plugins 部分
16. `CLAUDE.md` 中的插件列表与 `marketplace.json.plugins` 条目匹配
17. 项目根目录 `README.md` 存在且包含插件列表

## D. 文档完整性（5 项检查）

18. `docs/project-structure.md` 存在于项目根目录
19. `docs/plugins/` 目录存在
20. 每个插件都有对应的 `docs/plugins/<plugin-name>.md`
21. 每个插件都有 `README.md`，包含 `## What It Does`、`## Usage`、`## Authors` 部分
22. 每个 `docs/plugins/<plugin-name>.md` 包含：Purpose 部分、Components 表、Version 号

## E. 组件结构（6 项检查）

23. Skills：`skills/<name>/SKILL.md` frontmatter 仅有 `name` 和 `description`（无 `version`）
24. Agents：`agents/<name>.md` frontmatter 具有 `name`、`description`、`model` 和 `color`
25. Hooks：`hooks/hooks.json` 存在、为有效 JSON、具有事件结构
26. Rules：`rules/` 文件使用 kebab-case 命名
27. 组件 frontmatter `name` 与目录或文件名匹配
28. 组件 `description` 字段非空
