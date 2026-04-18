# marketplace-generator

## 用途

生成完整的 Claude Code 插件市场项目，包含引导式工作流和示例插件。提供市场创建、开发工作流强制执行和批量格式修复的 skills。

## 组件

| 类型 | 路径 | 用途 |
|------|------|------|
| 清单 | `.claude-plugin/plugin.json` | 插件名称、版本、描述 |
| Skill | `skills/marketplace-create/SKILL.md` | 引导用户从零开始创建完整的市场项目 |
| Skill | `skills/marketplace-dev-workflow/SKILL.md` | 添加、更新或移除插件时强制执行开发工作流 |
| Skill | `skills/marketplace-format/SKILL.md` | 扫描、诊断并批量修复现有项目的格式不一致 |
| Agent | `agents/marketplace-validator.md` | 验证市场结构和一致性 |

## 版本

0.1.1
