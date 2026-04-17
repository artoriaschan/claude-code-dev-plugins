# Plugin Development Workflow

## Creating a New Plugin

1. Create directory under `plugins/<name>/`
2. Create `.claude-plugin/plugin.json` with name, version, description
3. Add skills, agents as needed
4. If shipping rules, create `install.sh` to copy rules to `~/.claude/rules/`
5. Register in `.claude-plugin/marketplace.json`

## Registering a Plugin

After creating or modifying a plugin, ensure it's registered in the marketplace manifest:

Edit `.claude-plugin/marketplace.json` and add an entry:

```json
{
  "plugins": {
    "plugin-name": {
      "path": "./plugins/plugin-name"
    }
  }
}
```

## Versioning

Bump the `version` field in `.claude-plugin/plugin.json` after each meaningful change:

```json
{
  "name": "plugin-name",
  "version": "0.1.0"
}
```

## Creating a New Skill

1. Create `plugins/<plugin>/skills/<skill-name>/SKILL.md`
2. Write frontmatter with third-person description and trigger phrases
3. Write lean body in imperative form
4. Move detailed content to `references/` for progressive disclosure
5. Add examples in `examples/`

## Creating a New Agent

1. Create `plugins/<plugin>/agents/<agent-name>.md`
2. Write frontmatter with description and capabilities
3. Write system prompt with trigger conditions and output format

## Local Development & Debugging

### Add Local Marketplace

```bash
/plugin marketplace add ./my-marketplace
```

### Install and Activate

```bash
/plugin install cli-builder
/plugin install code-style
/reload-plugins
```

### Verify Installation

Run `/plugin` and check the **Installed** tab to confirm the plugin is loaded. For skills, verify auto-trigger by performing the expected action (e.g., editing a `.ts` file should trigger `ts-style`).

### Code-Style Rules

For `code-style` plugin, copy rules to `~/.claude/rules/`:

```bash
bash plugins/code-style/install.sh
```

### Iterative Changes

After modifying skills or agents:
1. Clear the cache: `rm -rf ~/.claude/plugins/cache`
2. Run `/reload-plugins` (or restart Claude Code)
3. Re-test the trigger action

### Cleanup

After testing, remove the local marketplace source:

```bash
/plugin marketplace remove ./my-marketplace
```

## Documentation Maintenance

**When modifying plugin files, update corresponding docs:**

| Change Location | Docs to Update |
|-----------------|----------------|
| `plugins/<name>/skills/`, `agents/`, `rules/`, `install.sh` | `plugins/<name>/README.md` |
| `plugins/<name>/README.md` | `README.md` (root) if the plugin's purpose/components changed |
| `README.md` (root) | `CLAUDE.md` if install commands or plugin list changed |

**Rules:**
- Document **only existing features** — never reference removed or deleted functionality
- Keep component counts accurate (skills, agents, rules)
- Install commands must match current behavior
- Update descriptions to reflect current behavior, not legacy behavior
