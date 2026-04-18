---
paths:
  - "**/*.ts"
  - "**/*.tsx"
  - "**/*.js"
  - "**/*.jsx"
---
# TypeScript 编码风格

> 本文件在 [common/coding-style.md](../common/coding-style.md) 的基础上扩展了 TypeScript 特定内容。

## 导入顺序

导入必须遵循以下确切顺序，用空行分隔：

1. **核心框架库**（react、vue 等）
2. **第三方库**（lodash、axios 等）
3. **内部模块** — 按路径距离排序（最近的优先）：
   - 同级目录导入（`./`）
   - 父级目录导入（`../`）
   - 更深层父级目录（`../../` 等）
4. **类型导入**（如果使用 `import type`）
5. **CSS/SCSS 导入**

```typescript
// 正确：正确的导入顺序
import React, { useState, useMemo } from 'react'
import { Route } from 'react-router-dom'

import { format, parseISO } from 'date-fns'
import axios from 'axios'

import { UserCard } from './user-card'
import { formatDate } from '../utils/date-utils'
import { api } from '../../api/client'

import type { User, UserProfile } from '../types/user'

import './user-profile.scss'
```

```typescript
// 错误：随机顺序
import { UserCard } from './user-card'
import React from 'react'
import './user-profile.scss'
import axios from 'axios'
import type { User } from '../types/user'
import { formatDate } from '../utils/date-utils'
```

## 类型和接口

### 公共 API

为导出的函数、共享工具函数和公共方法添加显式类型。让 TypeScript 推断局部变量类型。

```typescript
// 错误：导出函数没有类型
export function formatUser(user) {
  return `${user.firstName} ${user.lastName}`
}

// 正确：公共 API 上的显式类型
interface User {
  firstName: string
  lastName: string
}

export function formatUser(user: User): string {
  return `${user.firstName} ${user.lastName}`
}
```

### 接口 vs 类型别名

- 使用 `interface` 定义可能被扩展的对象形状
- 使用 `type` 定义联合类型、交叉类型、元组、映射类型
- 优先使用字符串字面量联合类型而不是 `enum`

```typescript
interface User {
  id: string
  email: string
}

type UserRole = 'admin' | 'member'
type UserWithRole = User & { role: UserRole }
```

### 避免 `any`

- 在应用代码中避免使用 `any`
- 对外部输入使用 `unknown`，然后安全地收窄类型
- 当类型依赖于调用者时使用泛型

```typescript
// 错误：any 消除了类型安全
function getErrorMessage(error: any) {
  return error.message
}

// 正确：unknown 强制安全收窄
function getErrorMessage(error: unknown): string {
  if (error instanceof Error) {
    return error.message
  }
  return 'Unexpected error'
}
```

## JavaScript 文件

在 `.js`/`.jsx` 文件中，使用 JSDoc 提供类型清晰度：

```javascript
/**
 * @param {{ firstName: string, lastName: string }} user
 * @returns {string}
 */
export function formatUser(user) {
  return `${user.firstName} ${user.lastName}`
}
```

## 文件结构

### 目录组织

按类型拆分，而不是按功能：

```
src/
├── components/
│   ├── user-card.tsx
│   └── user-profile.tsx
├── hooks/
│   └── use-auth.ts
├── utils/
│   ├── string-utils.ts
│   ├── date-utils.ts
│   └── api-utils.ts
├── types/
│   └── user.ts
├── api/
│   └── client.ts
└── styles/
    └── globals.scss
```

### 工具函数文件

按功能/域拆分 `utils/`：

```
utils/
├── string-utils.ts     # 字符串操作工具函数
├── date-utils.ts       # 日期格式化工具函数
├── api-utils.ts        # API 请求工具函数
└── validation-utils.ts # 表单验证工具函数
```

### 测试位置

测试放在项目根级别的 `__tests__/` 目录中：

```
project/
├── src/
│   ├── components/
│   └── utils/
└── __tests__/
    ├── user-card.test.tsx
    └── string-utils.test.ts
```

## 不可变性

使用展开运算符进行不可变更新：

```typescript
// 错误：就地修改
function updateUser(user: User, name: string): User {
  user.name = name
  return user
}

// 正确：展开运算符创建新对象
function updateUser(user: Readonly<User>, name: string): User {
  return { ...user, name }
}
```

## 错误处理

### 错误类型

- **Web 项目**：使用原生 `Error`
- **CLI/工具项目**：使用自定义错误类型

```typescript
// CLI 项目：自定义错误
class AppError extends Error {
  constructor(
    public code: string,
    message: string,
    public context?: Record<string, unknown>,
    public cause?: Error,
  ) {
    super(message)
    this.name = 'AppError'
  }
}

// 使用
throw new AppError(
  'FILE_NOT_FOUND',
  `文件 "${filePath}" 不存在。请检查路径后重试。`,
  { filePath, operation: 'read' },
  originalError
)
```

### 日志使用

```typescript
// Web 前端：console 即可
console.error('Failed to load user profile:', error)

// Node.js 后端：结构化日志（pino）
import pino from 'pino'
const logger = pino()

logger.error({
  level: 'error',
  errCode: 'DB_QUERY_FAILED',
  table: 'users',
  err: error
}, 'Database query failed')
```

## Console

- 生产代码中不要使用 `console.log`
- 使用适当的日志库代替
