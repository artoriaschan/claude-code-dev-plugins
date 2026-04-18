# docs/plugins/<plugin-name>.md 模板

将占位符替换为实际值。根据需要添加组件行。

```markdown
# <Plugin Name>

## Purpose
<插件描述>

## Components

| 类型 | 路径 | 用途 |
|------|------|---------|
| Manifest | `.claude-plugin/plugin.json` | 插件名称、版本、描述 |
| Skill | `skills/<skill-name>/SKILL.md` | <Skill 用途> |
| Agent | `agents/<agent-name>.md` | <Agent 用途> |
| Hook | `hooks/hooks.json` | <Hook 用途> |
| Rule | `rules/<rule-name>.md` | <Rule 用途> |

## Version
0.1.0
```

仅包含存在的组件行。删除插件不具有的组件行。
