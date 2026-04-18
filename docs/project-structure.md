# 项目结构

claude-code-dev-plugins 是一个 Claude Code 插件市场项目。

## 目录布局

```
claude-code-dev-plugins/
├── .claude-plugin/
│   └── marketplace.json    # 此市场中所有插件的注册表
├── CLAUDE.md               # Claude Code 的项目上下文
├── README.md               # 用户可见的文档
├── docs/
│   ├── project-structure.md # 本文件
│   ├── project-overview.md  # 项目目标和动机
│   ├── plugin-structure.md  # 插件清单和组件格式
│   ├── development-workflow.md  # 插件开发工作流
│   └── plugins/            # 每个插件的详细文档
│       ├── cli-builder.md
│       ├── code-style.md
│       └── marketplace-generator.md
└── plugins/
    ├── cli-builder/        # TypeScript CLI 脚手架
    ├── code-style/         # 编码风格约定
    └── marketplace-generator/  # 市场项目生成器
```

## 关键文件

### .claude-plugin/marketplace.json

市场配置文件。包含：
- `name`：市场名称（kebab-case）
- `description`：用途说明
- `owner`：市场所有者（名称 + 邮箱）
- `plugins[]`：插件条目数组，包含名称、描述、类别、源路径、标签和组件

### CLAUDE.md

Claude Code 的项目级上下文。链接到插件文档并定义活跃插件表。

## 插件工作原理

`plugins/` 下的每个插件都是一个自包含的 Claude Code 插件，拥有独立的清单文件 `.claude-plugin/plugin.json`。根目录的 `marketplace.json` 文件注册所有插件以供分发。用户可以安装整个市场并选择性启用单个插件。

## 插件约定

- 每个插件拥有自己的 `plugin.json` 清单，包含 name、version、description 和 author
- Skills 位于 `skills/<skill-name>/SKILL.md`
- Agents 位于 `agents/<agent-name>.md`
- Rules 位于 `rules/<category>/<rule-name>.md`
- 每个插件拥有 `README.md`，包含功能、用法和作者部分
