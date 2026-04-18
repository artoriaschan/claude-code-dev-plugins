# marketplace.json 模板

在项目根目录创建 `.claude-plugin/marketplace.json`。
从 `git config user.name` 和 `git config user.email` 获取作者信息。

```json
{
  "name": "<marketplace-name>",
  "version": "0.1.0",
  "description": "<description>",
  "owner": {
    "name": "<git user.name>",
    "email": "<git user.email>"
  },
  "plugins": [
    {
      "name": "<plugin-name>",
      "source": "./plugins/<plugin-name>"
    }
  ]
}
```

`plugins/` 中的每个插件都应在 `plugins` 数组中有一个条目，包含其名称和相对路径。
