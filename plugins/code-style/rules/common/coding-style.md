# 通用编码风格

适用于所有语言和框架的个人编码风格原则。当 AI 生成或修改代码时，这些规则始终被执行。

## 命名约定

始终遵循以下命名规则。违反这些规则属于风格错误。

| 元素 | 约定 | 示例 |
|---------|-----------|---------|
| 变量 | `camelCase` | `getUserData`、`isLoading` |
| 函数 | `camelCase` | `fetchUserProfile`、`validateInput` |
| 组件 | `PascalCase` | `UserProfile`、`Sidebar` |
| 常量 | `UPPER_SNAKE_CASE` | `MAX_RETRY_COUNT`、`API_BASE_URL` |
| 布尔变量 | `is`/`has`/`should` 前缀 | `isVisible`、`hasPermission`、`shouldRetry` |
| 事件回调 | `handle`/`on` 前缀 | `handleClick`、`onSubmit`、`handleError` |
| 自定义 Hook | `use` 前缀 + `camelCase` | `useAuth`、`useDebounce` |
| 文件 | `kebab-case` | `user-profile.ts`、`auth-utils.ts` |
| 文件夹 | `kebab-case` | `auth-components`、`api-utils` |

### 命名反面模式

```typescript
// 错误：名称泛化，布尔值没有前缀
let loading = true
function get(u) { ... }
const max = 100
function click() { ... }

// 正确：描述性命名，正确的前缀
let isLoading = true
function getUser(user: User) { ... }
const MAX_RETRY = 100
function handleClick() { ... }
```

```typescript
// 错误：变量使用 PascalCase
const UserProfile = fetchUser()

// 正确：变量使用 camelCase
const userProfile = fetchUser()
```

```typescript
// 错误：组件使用 camelCase
function userProfile() { return <div /> }

// 正确：组件使用 PascalCase
function UserProfile() { return <div /> }
```

## 不可变性

**始终创建新对象，永远不要修改现有对象。**

```typescript
// 错误：就地修改
function updateUser(user: User, name: string): User {
  user.name = name
  return user
}

// 正确：返回新副本
function updateUser(user: Readonly<User>, name: string): User {
  return { ...user, name }
}
```

理由：不可变数据可以防止隐藏的副作用，并使调试更容易。

## 注释

### 函数注释

- **仅**为公共 API 和复杂逻辑添加 JSDoc
- 简单函数不需要注释
- JSDoc 应记录参数、返回值和行为

```typescript
// 错误：在简单函数上添加 JSDoc
/**
 * 将两个数字相加
 * @param a - 第一个数字
 * @param b - 第二个数字
 * @returns 和
 */
function add(a: number, b: number): number {
  return a + b
}

// 正确：在公共 API 上添加 JSDoc
/**
 * 获取带有缓存偏好的用户配置文件。
 * 如果未设置偏好，则回退到默认偏好。
 *
 * @param userId - 用户的唯一标识符
 * @returns 合并了偏好的用户配置文件
 * @throws {NotFoundError} 如果用户不存在
 */
async function fetchUserProfile(userId: string): Promise<UserProfile> {
  // ...
}
```

### 组件注释

- **不要**为使用 TypeScript 类型定义 props 的组件添加注释
- 类型定义就是文档

```typescript
// 错误：冗余注释
// UserProfile 组件显示用户信息
interface UserCardProps { user: User; onSelect: (id: string) => void }
function UserCard({ user }: UserCardProps) { ... }

// 正确：仅保留类型定义
interface UserCardProps { user: User; onSelect: (id: string) => void }
function UserCard({ user }: UserCardProps) { ... }
```

### 行内注释

- 为重要/复杂的代码块添加行内注释
- 解释**为什么**和**上下文**，而不是代码**做了什么**

```typescript
// 正确：解释"为什么"
// 对搜索请求进行防抖，因为 API 有速率限制
// 我们不希望在每次按键时都发送请求
const debouncedSearch = useMemo(
  () => debounce(searchQuery, 300),
  [searchQuery]
)
```

### 特殊标签

使用标准化标签标记 TODO 和已知问题：

```typescript
// TODO: 为用户列表端点实现分页
// FIXME: 快速切换标签时的竞态条件
// HACK: 解决 Next.js 13 上的 SSR 水合不匹配问题
// NOTE: 此行为是为了无障碍而有意设计的
// WARN: 修改此内容将影响所有下游消费者
```

格式：`// TAG: 描述` — 始终包含描述。

## 错误处理

### 位置

- 尽可能优先使用**顶层统一**的错误处理
- 对于无法集中处理的错误，在**调用处**使用 try/catch 处理

```typescript
// 正确：顶层统一处理
async function loadUser(userId: string): Promise<User> {
  const user = await fetchUser(userId)
  return user
}

// 在调用者/顶层处理器中：
try {
  const user = await loadUser(id)
} catch (error) {
  // 统一处理：记录日志、显示提示、追踪错误
  handleError(error)
}
```

### 错误类型

- **Web 项目**：使用原生 `Error`
- **工具/CLI 项目**：使用自定义错误类型（例如 `AppError`、`ValidationError`）

### 错误消息格式

错误消息必须包含完整的披露信息：

- **错误代码/标识符** — 用于一致的程序化处理
- **人类可读的消息** — 具体且可操作
- **上下文** — 正在尝试什么操作，相关参数
- **堆栈追踪** — 保留用于调试

```typescript
// 错误：模糊的消息
throw new Error("出错了")

// 错误：暴露敏感信息
throw new Error("SQL 错误：'users' 表不存在，连接字符串：postgres://admin:secret@...")

// 正确：具体、可操作、安全
throw new AppError({
  code: "DB_TABLE_MISSING",
  message: "users 表不存在。请在启动服务器之前运行数据库迁移。",
  context: { table: "users", operation: "SELECT" },
  cause: originalError
})
```

### 系统错误 vs. 用户错误

- **系统错误**（磁盘已满、数据库宕机）：向用户显示"服务暂时不可用"，在内部记录完整详情
- **用户错误**（无效输入）：告诉用户具体需要修复什么

```typescript
// 错误：向用户暴露内部错误
catch (error) {
  return res.json({ error: "连接被拒绝：ECONNREFUSED 127.0.0.1:5432" })
}

// 正确：用户错误使用友好的消息，系统错误使用内部消息
catch (error) {
  if (error.code === "INVALID_INPUT") {
    return res.json({ error: "电子邮件地址格式无效。示例：user@example.com" })
  }
  // 系统错误：内部记录日志，显示通用消息
  logger.error("数据库连接失败", error)
  return res.json({ error: "服务暂时不可用。请稍后再试。" })
}
```

### 可操作建议

错误消息应该告诉用户**下一步该怎么做**：

```typescript
// 错误：没有操作指引
throw new Error("权限被拒绝")

// 正确：可操作
throw new Error("您没有查看此报告的权限。请联系团队管理员申请"报告查看者"角色。")
```

### 一致的错误代码

在整个项目中使用一致的错误代码系统：

```typescript
// 按域划分前缀
const ErrorCodes = {
  AUTH_INVALID_TOKEN: "AUTH_INVALID_TOKEN",
  AUTH_TOKEN_EXPIRED: "AUTH_TOKEN_EXPIRED",
  DB_QUERY_FAILED: "DB_QUERY_FAILED",
  VALIDATION_EMAIL_INVALID: "VALIDATION_EMAIL_INVALID",
} as const
```

## 日志

- 使用**结构化**日志数据
- **前端 Web**：不需要日志库（console 即可）
- **Node.js/后端**：使用结构化日志记录器，如 `pino` 或 `winston`

```typescript
// Node.js：结构化日志
logger.error({
  level: "error",
  errCode: "DB_QUERY_FAILED",
  table: "users",
  userId: request.userId,
  err: error
}, "数据库查询失败")
```

## 文件组织原则

- **高内聚，低耦合** — 每个文件应有单一用途
- **典型 200-400 行，最多 800 行** — 从大模块中提取工具函数
- **按类型组织** — `components/`、`hooks/`、`utils/`、`types/`
- **`utils/` 按功能拆分** — `utils/string-utils.ts`、`utils/date-utils.ts`
- **多个小文件 > 少量大文件**
