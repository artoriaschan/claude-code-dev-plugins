# Git 提交约定

> 当 AI 生成或修改 git 提交时应用的提交消息标准。

## 格式

遵循 [Conventional Commits](https://www.conventionalcommits.org/) 规范：

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

## 类型

| 类型 | 何时使用 |
|------|-------------|
| `feat` | 为用户新增的功能 |
| `fix` | 为用户修复 bug |
| `refactor` | 既不是修复也不是新功能的代码变更 |
| `docs` | 仅文档变更 |
| `test` | 添加或修复测试 |
| `style` | 代码风格变更（格式化、空格等） |
| `perf` | 性能改进 |
| `ci` | CI/CD 配置变更 |
| `chore` | 构建过程、依赖或其他维护性工作 |

## 规则

### 描述

- 使用祈使语气："add" 而不是 "added" 或 "adds"
- 开头不要大写
- 结尾不要句号
- 标题行最多 72 个字符

### 正文

- 可选，但对于破坏性变更和重大重构**必须**提供
- 解释**改了什么**和**为什么**，而不是**怎么改的**
- 每行 80 个字符自动换行
- 用空行与标题分隔

### 破坏性变更

- 在类型后标记 `!`：`feat!: ...`
- 脚注：`BREAKING CHANGE: <description>`

### 范围

- 可选，但对于多模块项目推荐使用
- 使用小写 kebab-case：`auth`、`user-card`、`api-client`

### 脚注标签

- `Closes #N` / `Fixes #N` — 链接到 issue
- `Refs #N` — 相关 issue
- `Co-authored-by: Name <email>` — 多位作者

## AI 特定规则

当 AI 生成提交消息时：

- **不要编造功能** — 仅描述实际的代码变更
- **不要夸大范围** — 如果只改了一个函数，就如实说明
- **不要用 `feat` 描述重构** — 即使代码看起来更好了也用 `refactor`
- **每次提交一个逻辑变更** — 优先使用多个小提交
- **永远不要提交不相关的变更** — 例如格式化和逻辑混在一个提交中
- **如果不确定类型** — 用 `chore` 而不是猜测

## 示例

```
# 正确：简单修复
fix: resolve race condition when switching user profiles

# 正确：带 scope 的功能
feat(auth): add JWT token refresh on 401 response

# 正确：带正文的重构
refactor: extract user validation into separate module

Split validation logic out of the auth handler so it can be
reused by the registration and profile-update flows.

# 正确：添加测试
test: add edge cases for date formatting utility

# 正确：文档
docs: update API endpoint reference in README

# 正确：破坏性变更
feat(api)!: change user search to return paginated results

BREAKING CHANGE: user search now returns { data, meta } instead
of a flat array. Update all call sites accordingly.

# 错误：过去时
WRONG: fixed the bug with user login

# 错误：大写开头，结尾有句号
WRONG: Add new endpoint.

# 错误：模糊
WRONG: update code

# 错误：夸大
WRONG: feat: complete user management system
(实际：只添加了一个输入验证函数)
```
