# marketplace-generator

## Purpose

Generate complete Claude Code plugin marketplace projects with guided workflows and example plugins. Provides skills for marketplace creation, development workflow enforcement, and batch format fixing.

## Components

| Type | Path | Purpose |
|------|------|---------|
| Manifest | `.claude-plugin/plugin.json` | Plugin name, version, description |
| Skill | `skills/marketplace-create/SKILL.md` | Guide users through creating a complete marketplace project from scratch |
| Skill | `skills/marketplace-dev-workflow/SKILL.md` | Enforce development workflow when adding, updating, or removing plugins |
| Skill | `skills/marketplace-format/SKILL.md` | Scan, diagnose, and batch-fix format inconsistencies in existing projects |
| Agent | `agents/marketplace-validator.md` | Validate marketplace structure and consistency |

## Version

0.1.1
