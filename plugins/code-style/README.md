# code-style

为 TypeScript、React、Vue 和 SCSS 项目的 AI 生成代码强制执行个人编码风格规范。

## 功能

提供完整的编码风格规则集、语言特定风格指南，以及自动触发的代码风格审查代理：
- 通用编码风格规范（命名、不可变性、文件组织、错误处理）
- TypeScript、React、Vue 和 SCSS 特定风格指南
- PostToolUse 钩子用于自动格式化和 lint
- 代码风格审查代理，在提交前进行深度审查

## 使用

技能根据文件类型自动触发：
- `code-style-principles` — 编写/修改任何代码时
- `ts-style` — 编辑 `.ts`/`.js`/`.tsx`/`.jsx` 文件时
- `react-style` — 编辑 `.tsx`/`.jsx` 文件时
- `vue-style` — 编辑 `.vue` 文件时
- `scss-style` — 编辑 `.scss`/`.sass` 文件时

### 安装规则

规则会被复制到 `~/.claude/rules/code-style/` 供 Claude Code 自动加载：

**远程安装（推荐）：**

```bash
curl -fsSL https://raw.githubusercontent.com/artoriaschan/claude-code-dev-plugins/main/install.sh | bash
```

**本地安装：**

```bash
# 在仓库根目录执行
./install.sh
```

## 组件

| 类型 | 名称 | 用途 |
|------|------|------|
| Skill | `code-style-principles` | 通用编码风格规范，含正反面示例 |
| Skill | `ts-style` | TypeScript 风格指南 |
| Skill | `react-style` | React 风格指南 |
| Skill | `vue-style` | Vue 风格指南 |
| Skill | `scss-style` | SCSS 风格指南 |
| Agent | `code-style-reviewer` | 提交前深度代码风格审查 |

## 作者

artoriaschan (dalecracker@gmail.com)
