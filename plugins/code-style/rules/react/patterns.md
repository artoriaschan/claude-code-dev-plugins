# React 模式

> React 项目的通用模式。

## 复合组件

当相关 UI 共享状态时使用复合组件：

```tsx
<Tabs defaultValue="overview">
  <Tabs.List>
    <Tabs.Trigger value="overview">Overview</Tabs.Trigger>
    <Tabs.Trigger value="settings">Settings</Tabs.Trigger>
  </Tabs.List>
  <Tabs.Content value="overview">...</Tabs.Content>
  <Tabs.Content value="settings">...</Tabs.Content>
</Tabs>
```

## 容器 / 展示拆分

```tsx
// 容器：负责数据获取
function UserListContainer() {
  const { data: users } = useQuery({ queryKey: ['users'], queryFn: fetchUsers })
  return <UserList items={users ?? []} />
}

// 展示：纯渲染
function UserList({ items }: { items: User[] }) {
  return items.map(u => <UserCard key={u.id} user={u} />)
}
```

## Render Props / Slots

当行为共享但标记必须变化时使用 render props：

```tsx
function MouseTracker({ render }: { render: (pos: { x: number; y: number }) => React.ReactNode }) {
  const [pos, setPos] = useState({ x: 0, y: 0 })
  // ... 鼠标追踪
  return <>{render(pos)}</>
}
```

## 乐观更新

```tsx
function useOptimisticUpdate<T>(key: string[], data: T) {
  const queryClient = useQueryClient()

  return {
    onMutate: async () => {
      await queryClient.cancelQueries({ queryKey: key })
      const previous = queryClient.getQueryData(key)
      queryClient.setQueryData(key, data)
      return { previous }
    },
    onError: (_err, _vars, context: { previous: T | undefined }) => {
      queryClient.setQueryData(key, context.previous)
    },
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: key })
    }
  }
}
```
