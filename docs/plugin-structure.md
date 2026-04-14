# Plugin Structure & Manifest Format

## Directory Layout

Each plugin lives under `plugins/<name>/`:

```
plugins/<name>/
├── README.md              # Plugin documentation
├── skills/                # Auto-activating skills
│   └── <skill-name>/
│       ├── SKILL.md       # Required
│       ├── references/    # Detailed docs loaded on demand
│       ├── examples/      # Working examples
│       └── scripts/       # Utility scripts
├── agents/                # Subagent definitions
│   └── <agent-name>.md    # Agent with frontmatter + system prompt
└── hooks/
    └── hooks.json          # Event handler configuration
```

## Manifest (.claude-plugin/plugin.json)

Located at the project root, shared by all plugins:

```json
{
  "name": "cli-builder",
  "version": "0.1.0",
  "description": "Brief description",
  "author": { "name": "artorias" },
  "skills": "./plugins/cli-builder/skills",
  "agents": "./plugins/cli-builder/agents",
  "hooks": "./plugins/cli-builder/hooks/hooks.json"
}
```

### Manifest Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Unique kebab-case identifier |
| `version` | No | Semver version |
| `description` | No | One-line purpose summary |
| `author` | No | Author info |
| `skills` | No | Relative path to skills directory |
| `agents` | No | Relative path or array of agent paths |
| `hooks` | No | Path to hooks.json |

### Path Rules

- Paths are relative to the `.claude-plugin/` directory (parent of plugin.json)
- Must start with `./`
- Cannot be absolute

## Skill Frontmatter (SKILL.md)

```yaml
---
name: skill-name
description: Third-person description with specific trigger phrases like "do X", "create Y"
version: 0.1.0
---
```

### Description Requirements

- Use third person: "This skill should be used when..."
- Include specific trigger phrases in quotes
- Be concrete, not vague

## Agent Frontmatter (.md)

```yaml
---
description: What this agent does and when it triggers
capabilities:
  - Specific task 1
  - Specific task 2
---
```

## Hooks Format (hooks.json)

```json
{
  "PostToolUse": [{
    "matcher": "Write|Edit",
    "hooks": [{ "type": "prompt", "prompt": "Instructions..." }]
  }]
}
```

### Available Events

`PreToolUse`, `PostToolUse`, `Stop`, `SubagentStop`, `SessionStart`, `SessionEnd`, `UserPromptSubmit`, `PreCompact`, `Notification`
