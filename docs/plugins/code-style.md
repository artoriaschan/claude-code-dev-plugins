# code-style

## Purpose

Enforce personal coding style conventions for AI-generated code across TypeScript, React, Vue, and SCSS projects. Provides rules, style guides, and an auto-triggered code style reviewer agent.

## Components

| Type | Path | Purpose |
|------|------|---------|
| Manifest | `.claude-plugin/plugin.json` | Plugin name, version, description |
| Skill | `skills/code-style-principles/SKILL.md` | Universal coding style principles with good vs bad examples |
| Skill | `skills/ts-style/SKILL.md` | TypeScript style guide — types, import order, file structure |
| Skill | `skills/react-style/SKILL.md` | React style guide — component patterns, hooks, error boundaries |
| Skill | `skills/vue-style/SKILL.md` | Vue style guide — composition API, component patterns |
| Skill | `skills/scss-style/SKILL.md` | SCSS style guide — naming conventions, nesting limits |
| Agent | `agents/code-style-reviewer.md` | Deep code style review before commits |

## Version

0.1.4
