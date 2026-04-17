# Installation & Usage

## Installing Plugins

### Via Claude Code Marketplace

```bash
/plugin marketplace add artoriaschan/claude-code-dev-plugins
/plugin install cli-builder
/plugin install code-style
```

### Manual Rule Installation

Some plugins (like `code-style`) ship coding style rules that are copied to `~/.claude/rules/` for auto-loading:

**Remote install (recommended):**

```bash
curl -fsSL https://raw.githubusercontent.com/artoriaschan/claude-code-dev-plugins/main/plugins/code-style/install.sh | bash
```

**Local install (from plugin directory):**

```bash
cd plugins/code-style && ./install.sh
```

**Local install (from repo root):**

```bash
bash plugins/code-style/install.sh
```

The install script:
- Detects local vs remote mode automatically
- Removes existing rules before installing fresh copy

Skills and agents are auto-discovered — no manual setup required.

## Available Plugins

### cli-builder

TypeScript CLI project scaffolding with simple mode support.

See [`plugins/cli-builder/README.md`](../plugins/cli-builder/README.md) for details.

### code-style

Enforce personal coding style conventions for AI-generated code across TypeScript, React, Vue, and SCSS.

See [`plugins/code-style/README.md`](../plugins/code-style/README.md) for details.
