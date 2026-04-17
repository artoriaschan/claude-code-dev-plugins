# marketplace-generator

Generate complete Claude Code plugin marketplace projects with guided workflows and example plugins.

## What It Does

Provides three skills and one agent for managing Claude Code plugin marketplaces:
- `marketplace-create` — Guide users through creating a complete marketplace project from scratch (Collect, Generate, Document, Validate phases)
- `marketplace-dev-workflow` — Enforce development workflow standards when adding, updating, or removing plugins
- `marketplace-format` — Scan, diagnose, and batch-fix format inconsistencies in existing marketplace projects
- `marketplace-validator` agent — Validate marketplace structure and consistency

## Usage

Trigger phrases:
- "create a plugin marketplace", "set up a new marketplace" — marketplace-create
- "add a new plugin", "update the X plugin" — marketplace-dev-workflow
- "format marketplace", "fix plugin structure" — marketplace-format

## Components

| Type | Name | Purpose |
|------|------|---------|
| Skill | `marketplace-create` | Guide users through creating a complete marketplace project from scratch |
| Skill | `marketplace-dev-workflow` | Enforce development workflow when adding, updating, or removing plugins |
| Skill | `marketplace-format` | Scan, diagnose, and batch-fix format inconsistencies in existing projects |
| Agent | `marketplace-validator` | Validate marketplace structure and consistency |

## Authors

artoriaschan (dalecracker@gmail.com)
