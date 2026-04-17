# code-style

Enforce personal coding style conventions for AI-generated code across TypeScript, React, Vue, and SCSS projects.

## What It Does

Provides a complete set of coding style rules, language-specific style guides, and an auto-triggered code style reviewer:
- Universal coding style principles (naming, immutability, file organization, error handling)
- TypeScript, React, Vue, and SCSS specific style guides
- PostToolUse hooks for auto-formatting and linting
- Code style reviewer agent for deep review before commits

## Usage

Skills auto-trigger based on file types:
- `code-style-principles` — writing/modifying any code
- `ts-style` — editing `.ts`/`.js`/`.tsx`/`.jsx` files
- `react-style` — editing `.tsx`/`.jsx` files
- `vue-style` — editing `.vue` files
- `scss-style` — editing `.scss`/`.sass` files

### Installing Rules

Rules are copied to `~/.claude/rules/code-style/` for Claude Code to auto-load them:

**Remote install (recommended):**

```bash
curl -fsSL https://raw.githubusercontent.com/artoriaschan/claude-code-dev-plugins/main/plugins/code-style/install.sh | bash
```

**Local install:**

```bash
./install.sh
```

## Components

| Type | Name | Purpose |
|------|------|---------|
| Skill | `code-style-principles` | Universal coding style principles with good vs bad examples |
| Skill | `ts-style` | TypeScript style guide |
| Skill | `react-style` | React style guide |
| Skill | `vue-style` | Vue style guide |
| Skill | `scss-style` | SCSS style guide |
| Agent | `code-style-reviewer` | Deep code style review before commits |

## Authors

artoriaschan (dalecracker@gmail.com)
