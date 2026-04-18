# CLAUDE.md 模板

将占位符替换为实际值。为每个插件添加一行链接。

```markdown
# CLAUDE.md

这是一个 Claude Code 插件 marketplace 项目。

## Project Structure
- `.claude-plugin/marketplace.json` — Marketplace 配置和插件注册表
- `plugins/` — 所有插件，每个都有各自的 `.claude-plugin/plugin.json`
- `docs/` — 项目和插件文档
  - `docs/project-structure.md` — 整体项目布局和目录用途
  - `docs/plugins/` — 每个插件的详细文档

## Plugins
<!-- 插件列表在此维护。添加/删除插件时相应更新。 -->
- [<plugin-name>](docs/plugins/<plugin-name>.md) — <description>

## Project Structure
完整项目布局和目录用途参考 [docs/project-structure.md](docs/project-structure.md)。
```
