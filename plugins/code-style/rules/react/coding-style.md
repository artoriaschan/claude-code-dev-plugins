---
paths:
  - "**/*.tsx"
  - "**/*.jsx"
---
# React 编码风格

> 本文件在 [common/coding-style.md](../common/coding-style.md) 的基础上扩展了 React 特定内容。

## 组件结构

### 拆分组件 + 样式 + 工具函数

```tsx
// user-profile.tsx
import { useState } from 'react'
import type { User } from '../types/user'
import { formatUser } from '../utils/string-utils'
import './user-profile.scss'

interface UserProfileProps {
  user: User
  onEdit: (id: string) => void
}

export function UserProfile({ user, onEdit }: UserProfileProps) {
  return (
    <div className="user-profile">
      <h1>{formatUser(user)}</h1>
      <button onClick={() => onEdit(user.id)}>Edit</button>
    </div>
  )
}
```

### 文件拆分

- 组件逻辑放在 `.tsx` 文件中
- 样式放在 `.scss` 文件中（同目录放置）
- 组件特定的工具函数放在单独的 `.ts` 文件中
- 测试放在项目根级别的 `__tests__/` 目录中

## Hooks 使用

### 自定义 Hooks

- 始终使用 `use` 前缀：`useAuth`、`useDebounce`
- 保持 hook 专注于单一关注点
- 返回一致的数据结构：数据 + 操作

```tsx
// 错误：hook 做的事情太多
function useUserProfile(id: string) {
  const [user, setUser] = useState()
  const [posts, setPosts] = useState()
  const [comments, setComments] = useState()
  const [settings, setSettings] = useState()
  // 在一个 hook 中获取所有内容
  return { user, posts, comments, settings, ...actions }
}

// 正确：专注的 hook
function useUser(id: string) { ... }
function useUserPosts(userId: string) { ... }
```

### 规则

- 仅在顶层调用 hooks
- 仅在 React 函数组件或其他 hooks 中调用 hooks
- 不要将应该在事件处理器中的副作用放在 hooks 中

## 错误边界

每个 React 应用程序都必须有一个错误边界：

```tsx
class ErrorBoundary extends React.Component<
  { children: React.ReactNode; fallback?: React.ReactNode },
  { hasError: boolean; error: Error | null }
> {
  constructor(props: { children: React.ReactNode; fallback?: React.ReactNode }) {
    super(props)
    this.state = { hasError: false, error: null }
  }

  static getDerivedStateFromError(error: Error) {
    return { hasError: true, error }
  }

  render() {
    if (this.state.hasError) {
      return (
        this.props.fallback ?? (
          <div role="alert">
            <h2>出现错误</h2>
            <p>请尝试刷新页面。如果问题仍然存在，请联系支持。</p>
          </div>
        )
      )
    }
    return this.props.children
  }
}

// 使用
<ErrorBoundary>
  <App />
</ErrorBoundary>
```

## Props

- 使用命名的 `interface` 或 `type` 定义 props
- 显式类型化回调 props
- 除非有特定理由，否则不要使用 `React.FC`

```tsx
interface UserCardProps {
  user: User
  onSelect: (id: string) => void
}

function UserCard({ user, onSelect }: UserCardProps) {
  return <button onClick={() => onSelect(user.id)}>{user.email}</button>
}
```

## 状态管理

- 使用 `useState` 管理组件局部状态
- 使用 React Context 在组件树之间共享状态
- 使用 React Query/SWR 管理服务端状态（数据获取）
- 不要将服务端状态复制到本地存储中
