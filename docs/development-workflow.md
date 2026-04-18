# 插件开发工作流

## 1. 创建新插件

1. 在 `plugins/<name>/` 下创建目录
2. 创建 `.claude-plugin/plugin.json`，包含 `name`、`version`、`description`
3. 按需添加 skills 和 agents
4. 如需提供 rules，创建 `install.sh` 将 rules 复制到 `~/.claude/rules/`
5. 在 `.claude-plugin/marketplace.json` 中注册

## 2. 注册插件

创建或修改插件后，确保它在市场清单中已注册：

```json
{
  "plugins": {
    "plugin-name": {
      "path": "./plugins/plugin-name"
    }
  }
}
```

## 3. 版本管理

每次有意义的更改后，更新 `.claude-plugin/plugin.json` 中的 `version` 字段。使用[语义化版本](https://semver.org/)：

- **patch** — bug 修复、文档、小改动
- **minor** — 新 skills、agents 或功能
- **major** — 对现有组件的破坏性变更

```json
{
  "name": "plugin-name",
  "version": "0.1.0"
}
```

## 4. 创建组件

### Skills

1. 创建 `plugins/<plugin>/skills/<skill-name>/SKILL.md`
2. 编写包含第三人称描述和触发短语的 frontmatter
3. 以祈使句形式编写简洁主体
4. 将详细内容移至 `references/` 实现渐进式披露
5. 在 `examples/` 中添加示例

### Agents

1. 创建 `plugins/<plugin>/agents/<agent-name>.md`
2. 编写包含描述和 capabilities 的 frontmatter
3. 编写包含触发条件和输出格式的系统提示

## 5. 本地开发与调试

### 设置

```bash
# 添加本地市场
/plugin marketplace add ./my-marketplace

# 安装插件
/plugin install cli-builder
/plugin install code-style

# 对于 code-style 插件，还需复制 rules
bash plugins/code-style/install.sh
```

### 验证

运行 `/plugin` 并检查 **Installed** 标签。对于 skills，执行预期操作（如编辑 `.ts` 文件验证 `ts-style` 是否自动触发）。

### 迭代

修改 skills 或 agents 后：

1. 清除缓存：`rm -rf ~/.claude/plugins/cache`
2. 运行 `/reload-plugins`（或重启 Claude Code）
3. 重新测试触发

### 清理

```bash
/plugin marketplace remove ./my-marketplace
```

## 6. 提交前检查清单

提交插件更改前：

- [ ] `.claude-plugin/plugin.json` 中的版本已更新
- [ ] 如果元数据有变，`.claude-plugin/marketplace.json` 已更新
- [ ] 插件 README.md 反映了当前组件
- [ ] 如果插件用途或组件有变，根 `README.md` 已更新
- [ ] 如果插件列表或安装命令有变，`CLAUDE.md` 已更新
- [ ] 无文档引用失效或功能过时的情况

## 7. 文档维护

### 交叉引用规则

| 修改时 | 同时检查/更新 |
|--------|---------------|
| `docs/*.md` | 根 `README.md` — 移除或更新指向已更改文件的链接 |
| `plugins/<name>/skills/`、`agents/`、`rules/`、`install.sh` | `plugins/<name>/README.md` — 更新组件数量和描述 |
| `plugins/<name>/README.md` | 根 `README.md` — 如果插件用途或组件有变则同步 |
| 根 `README.md` | `CLAUDE.md` — 如果安装命令或插件列表有变则同步 |

### 内容规则

- **仅记录现有功能** — 不要引用已删除的功能
- 保持组件数量准确（skills、agents、rules）
- 安装命令必须与当前行为一致
- 更新描述以反映当前行为，而非历史行为
