# docs/project-structure.md 模板

将 `<marketplace-name>` 替换为实际值。

```markdown
# 项目结构

<marketplace-name> 是一个 Claude Code 插件 marketplace 项目。

## Directory Layout

```
<marketplace-name>/
├── .claude-plugin/
│   └── marketplace.json    # 此 marketplace 中所有插件的注册表
├── CLAUDE.md               # Claude Code 的项目上下文
├── README.md               # 面向用户的文档
├── docs/
│   ├── project-structure.md # 此文件
│   └── plugins/            # 每个插件的详细文档
└── plugins/
    └── <plugin-name>/      # 各个插件
        ├── .claude-plugin/
        │   └── plugin.json # 插件清单
        ├── skills/         # 自动激活的 skills（如有）
        ├── agents/         # 子代理定义（如有）
        ├── hooks/          # 事件处理器（如有）
        ├── rules/          # 自定义规则（如有）
        └── README.md       # 插件文档
```

## Key Files

### .claude-plugin/marketplace.json
marketplace 配置文件。包含：
- `name`：Marketplace 名称（kebab-case）
- `version`：Semver 版本
- `description`：用途说明
- `plugins[]`：指向每个插件的 { name, path } 对象数组

### CLAUDE.md
项目级 Claude Code 上下文。链接到插件文档。

## How Plugins Work
`plugins/` 中的每个插件都是一个独立的 Claude Code 插件，拥有自己的清单。
根目录的 marketplace.json 文件注册所有插件以供分发。
用户可以安装整个 marketplace 并选择性地启用各个插件。
```
