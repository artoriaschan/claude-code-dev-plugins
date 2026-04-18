# 通用模式

> 所有项目中使用的设计模式和架构原则。

## 组件组合

### 容器 / 展示拆分

- 容器组件负责数据加载和副作用
- 展示组件接收 props 并渲染 UI
- 展示组件应保持纯粹

```tsx
// 错误：混合关注点
function UserList() {
  const [users, setUsers] = useState([])
  useEffect(() => { fetch('/api/users').then(r => r.json()).then(setUsers) }, [])
  return users.map(u => <div key={u.id}>{u.name}</div>)
}

// 正确：拆分容器和展示
function UserListContainer() {
  const [users, setUsers] = useState([])
  useEffect(() => { fetch('/api/users').then(r => r.json()).then(setUsers) }, [])
  return <UserList items={users} />
}

function UserList({ items }: { items: User[] }) {
  return items.map(u => <div key={u.id}>{u.name}</div>)
}
```

## 状态管理

按状态类型分离关注点：

| 关注点 | 工具 |
|---------|---------|
| 服务端状态 | React Query、SWR、tRPC |
| 客户端状态 | Zustand、Jotai、Context |
| URL 状态 | Search params、route segments |
| 表单状态 | React Hook Form、Formik |

- 不要将服务端状态复制到客户端存储中
- 派生值而不是存储冗余的计算状态

## URL 作为状态

将可共享的状态持久化到 URL 中：
- 筛选条件、排序顺序、分页
- 活动标签页、搜索查询

## 不可变性

参见 [coding-style.md](./coding-style.md) — 不可变性是核心原则。
