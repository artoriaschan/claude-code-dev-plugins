# Claude Code Dev Plugins

个人 Claude Code 插件集合。

## 插件列表

| 插件 | 用途 | 详情 |
|------|------|------|
| **cli-builder** | TypeScript CLI 项目脚手架（含简洁模式）和命令模板 | [plugins/cli-builder/README.md](plugins/cli-builder/README.md) |
| **code-style** | TypeScript、React、Vue 和 SCSS 编码风格规范 | [plugins/code-style/README.md](plugins/code-style/README.md) |
| **marketplace-generator** | 生成完整的 Claude Code 插件市场项目，支持引导式工作流和格式化现有项目 | [plugins/marketplace-generator/README.md](plugins/marketplace-generator/README.md) |

## 快速开始

在 Claude Code 中添加市场并安装插件：

```
/plugin marketplace add artoriaschan/claude-code-dev-plugins
/plugin install cli-builder
/plugin install code-style
```

> **注意：** 安装 `code-style` 插件后，需要运行以下命令安装规则文件：
>
> ```bash
> curl -fsSL https://raw.githubusercontent.com/artoriaschan/claude-code-dev-plugins/main/plugins/code-style/install.sh | bash
> ```

## 添加新插件

1. 在 `plugins/<name>/` 下创建目录
2. 创建 `.claude-plugin/plugin.json` 清单文件
3. 按需添加 skills 和 agents
4. 在 [`.claude-plugin/marketplace.json`](.claude-plugin/marketplace.json) 中注册

详见 [docs/development-workflow.md](docs/development-workflow.md)。

## 文档

| 主题 | 文件 |
|------|------|
| 项目简介和目标 | [docs/project-overview.md](docs/project-overview.md) |
| 插件结构和清单格式 | [docs/plugin-structure.md](docs/plugin-structure.md) |
| 插件开发工作流 | [docs/development-workflow.md](docs/development-workflow.md) |

## 许可证

MIT
