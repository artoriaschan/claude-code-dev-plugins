# docs/plugins/<plugin-name>.md Template

Replace placeholders with actual values. Add component rows as needed.

```markdown
# <Plugin Name>

## Purpose
<Plugin description>

## Components

| Type | Path | Purpose |
|------|------|---------|
| Manifest | `.claude-plugin/plugin.json` | Plugin name, version, description |
| Skill | `skills/<skill-name>/SKILL.md` | <Skill purpose> |
| Agent | `agents/<agent-name>.md` | <Agent purpose> |
| Hook | `hooks/hooks.json` | <Hook purpose> |
| Rule | `rules/<rule-name>.md` | <Rule purpose> |

## Version
0.1.0
```

Only include rows for components that exist. Remove rows for components the plugin does not have.
