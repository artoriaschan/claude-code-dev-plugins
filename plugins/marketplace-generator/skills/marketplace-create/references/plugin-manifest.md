# Plugin Manifest Template

Create `.claude-plugin/plugin.json` for each plugin.
Get author info from `git config user.name` and `git config user.email`.

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
