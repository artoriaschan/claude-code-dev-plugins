# 插件清单模板

为每个插件创建 `.claude-plugin/plugin.json`。
从 `git config user.name` 和 `git config user.email` 获取作者信息。

```json
{
  "name": "<plugin-name>",
  "version": "0.1.0",
  "description": "<description>",
  "author": {
    "name": "<git user.name>",
    "email": "<git user.email>"
  }
}
```
