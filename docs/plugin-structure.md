# 插件结构与清单格式

## 目录布局

每个插件位于 `plugins/<name>/` 下：

```
plugins/<name>/
├── .claude-plugin/
│   └── plugin.json        # 插件清单（每个插件独立）
├── README.md              # 插件文档
├── skills/                # 自动激活的 skills
│   └── <skill-name>/
│       ├── SKILL.md       # 必需
│       ├── references/    # 按需加载的详细文档
│       ├── examples/      # 工作示例
│       └── scripts/       # 实用脚本
├── agents/                # 子 agent 定义
│   └── <agent-name>.md    # 包含 frontmatter + 系统提示的 agent
├── install.sh             # 可选的安装脚本（下载或复制 rules）
└── rules/                 # 编码风格 rules（可选）
    └── <language>/
        └── *.md           # rules 文件
```

## 清单（.claude-plugin/plugin.json）

每个插件拥有独立的清单文件，位于 `plugins/<name>/.claude-plugin/plugin.json`：

```json
{
  "name": "code-style",
  "version": "0.1.3",
  "description": "强制执行个人编码风格约定。",
  "author": { "name": "artoriaschan" }
}
```

Skills 和 agents 从标准目录**自动发现**：

| 组件 | 自动发现路径 |
|------|--------------|
| Skills | `plugins/<name>/skills/<skill-name>/SKILL.md` |
| Agents | `plugins/<name>/agents/<agent-name>.md` |

### 清单字段

| 字段 | 必填 | 描述 |
|------|------|------|
| `name` | 是 | 唯一的 kebab-case 标识符 |
| `version` | 否 | 语义化版本号 |
| `description` | 否 | 一行用途说明 |
| `author` | 否 | 作者信息 |
| `skills` | 否 | skills 目录的相对路径（覆盖自动发现） |
| `agents` | 否 | agent 路径的相对路径或数组（覆盖自动发现） |

### 路径规则

- 路径相对于 `.claude-plugin/` 目录（plugin.json 的父目录）
- 必须以 `./` 开头
- 不能是绝对路径

## Skill Frontmatter（SKILL.md）

```yaml
---
name: skill-name
description: 使用第三人称描述，包含具体触发短语如 "do X"、"create Y"
version: 0.1.0
---
```

### 描述要求

- 使用第三人称："此技能应在...时使用"
- 包含具体的触发短语（用引号标注）
- 具体明确，不要模糊笼统

## Agent Frontmatter（.md）

```yaml
---
description: agent 的功能和触发时机
capabilities:
  - 具体任务 1
  - 具体任务 2
---
```

## Rules（可选）

插件可在 `plugins/<name>/rules/` 下提供编码风格规则。`install.sh` 脚本将它们复制到 `~/.claude/rules/` 供 Claude Code 自动加载：

```bash
# 远程安装（无需克隆仓库）
curl -fsSL https://raw.githubusercontent.com/artoriaschan/claude-code-dev-plugins/main/plugins/code-style/install.sh | bash
```

安装脚本：
- 自动检测本地和远程模式
- 安装前先移除现有 rules，然后安装全新副本

Rules 采用分层结构：

```
rules/
├── common/              # 跨语言通用原则
│   ├── coding-style.md  # 命名、不可变性、错误处理、注释
│   ├── patterns.md      # 设计模式
│   └── testing.md       # 测试约定
├── <language>/          # 语言特定规则
│   ├── coding-style.md  # 语言约定
│   ├── patterns.md      # 语言模式
└── <framework>/         # 框架特定规则
    ├── coding-style.md
    └── patterns.md
```

Rules 使用相对路径引用（`../common/xxx.md`）来交叉引用共享原则。
