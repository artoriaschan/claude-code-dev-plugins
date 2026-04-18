# code-style

## 用途

为 TypeScript、React、Vue 和 SCSS 项目的 AI 生成代码强制执行个人编码风格规范。提供 rules、风格指南和自动触发的代码风格审查 agent。

## 组件

| 类型 | 路径 | 用途 |
|------|------|------|
| 清单 | `.claude-plugin/plugin.json` | 插件名称、版本、描述 |
| Skill | `skills/code-style-principles/SKILL.md` | 通用编码风格规范，含正反面示例 |
| Skill | `skills/ts-style/SKILL.md` | TypeScript 风格指南 — 类型、导入顺序、文件结构 |
| Skill | `skills/react-style/SKILL.md` | React 风格指南 — 组件模式、hooks、错误边界 |
| Skill | `skills/vue-style/SKILL.md` | Vue 风格指南 — Composition API、组件模式 |
| Skill | `skills/scss-style/SKILL.md` | SCSS 风格指南 — 命名约定、嵌套限制 |
| Agent | `agents/code-style-reviewer.md` | 提交前深度代码风格审查 |

## 版本

0.1.4
