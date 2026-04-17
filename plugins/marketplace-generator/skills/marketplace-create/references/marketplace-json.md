# marketplace.json Template

Create `.claude-plugin/marketplace.json` at the project root.
Get author info from `git config user.name` and `git config user.email`.

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

Each plugin in `plugins/` should have an entry in the `plugins` array with its name and relative path.
