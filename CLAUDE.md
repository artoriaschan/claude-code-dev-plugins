# Claude Code 开发插件

## 项目目的

本项目管理 Claude Code 插件，用于个人开发工作流。`plugins/` 下的每个插件都独立维护，拥有自己的清单文件和组件。

**仓库地址：** https://github.com/artoriaschan/claude-code-dev-plugins

## 关键：双层架构

此仓库有多个 `.claude-plugin/` 文件夹:

| 层级  | 路径                                             | 目的              |
| ------ | ------------------------------------------------ | -------------------- |
| 根目录   | `/.claude-plugin/marketplace.json`               | 市场清单 |
| Plugin | `/plugins/{plugin-name}/.claude-plugin/plugin.json` | 插件清单      |

**测试**: `claude --plugin-dir plugins/{plugin-name}` (非根目录)

## 关键约定

- 路径：使用 ${CLAUDE_PLUGIN_ROOT} 表示可移植路径
- 技能：渐进式披露（SKILL.md + references/ + examples/）
- 描述：第三人称（"当使用此技能时..."）
- 版本：同步于 plugin.json、marketplace.json


## 基本命令

```bash
# 本地测试插件
claude --plugin-dir plugins/{plugin-name}

# 校验markdown
markdownlint-cli2 '**/*.md'

# 格式化markdown
prettier --write '**/*.md'

# 校验shell脚本
shellcheck plugins/{plugin-name}/skills/*/scripts/*.sh

# 校验YAML文件
uvx yamllint .github/workflows/
```
