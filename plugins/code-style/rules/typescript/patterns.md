# TypeScript 模式

> TypeScript 项目的通用模式。

## 仓储模式

将数据访问封装在一致的接口后面：

```typescript
interface UserRepository {
  findById(id: string): Promise<User | null>
  findAll(filter?: UserFilter): Promise<User[]>
  create(data: CreateUserInput): Promise<User>
  update(id: string, data: UpdateUserInput): Promise<User>
  delete(id: string): Promise<void>
}

class HttpUserRepository implements UserRepository {
  async findById(id: string): Promise<User | null> {
    const res = await fetch(`/api/users/${id}`)
    if (!res.ok) return null
    return res.json()
  }
  // ...
}
```

## API 响应信封

对所有 API 响应使用一致的响应格式：

```typescript
interface ApiResponse<T> {
  success: boolean
  data: T | null
  error: string | null
  meta?: {
    total: number
    page: number
    limit: number
  }
}
```

## Result 类型

对可能失败的操作使用 Result 类型：

```typescript
type Result<T, E = Error> =
  | { ok: true; value: T }
  | { ok: false; error: E }

async function loadUser(id: string): Promise<Result<User>> {
  try {
    const user = await fetchUser(id)
    return { ok: true, value: user }
  } catch (error) {
    return { ok: false, error: error as Error }
  }
}
```
