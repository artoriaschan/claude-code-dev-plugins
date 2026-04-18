---
paths:
  - "**/*.vue"
---
# Vue 编码风格

> 本文件在 [common/coding-style.md](../common/coding-style.md) 的基础上扩展了 Vue 特定内容。

## 组件结构

### 使用组合式 API（`<script setup>`）

新组件始终使用 `<script setup>` 和组合式 API：

```vue
<script setup lang="ts">
import { ref, computed, watch } from 'vue'
import type { User } from '../types/user'
import { formatUser } from '../utils/string-utils'
import './user-profile.scss'

interface Props {
  user: User
}

interface Emits {
  (e: 'edit', id: string): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

const isLoading = ref(false)

const displayName = computed(() => formatUser(props.user))

function handleEdit() {
  emit('edit', props.user.id)
}
</script>

<template>
  <div class="user-profile">
    <h1>{{ displayName }}</h1>
    <button @click="handleEdit">Edit</button>
  </div>
</template>
```

### 文件拆分

- 组件放在 `.vue` 文件中（单文件组件）
- 样式放在 `<style lang="scss" scoped>` 或同目录的 `.scss` 文件中
- 组件特定的工具函数放在单独的 `.ts` 文件中
- 测试放在项目根级别的 `__tests__/` 目录中

## 组合式 API 规则

### Ref vs Reactive

- 对原始值和单个对象使用 `ref()`
- 对始终一起更新的分组状态使用 `reactive()`
- 在 script 中始终使用 `.value` 访问 ref 值

```vue
<script setup lang="ts">
// 正确：ref 用于原始值
const count = ref(0)
const user = ref<User | null>(null)

// 正确：reactive 用于分组状态
const formState = reactive({
  name: '',
  email: '',
  password: ''
})
</script>
```

### 计算属性

- 对派生状态使用 `computed()`
- 不要修改计算属性的值

```vue
<script setup lang="ts">
const filteredUsers = computed(() =>
  users.value.filter(u => u.isActive)
)
</script>
```

### Watch 用法

- 对基于状态变化的副作用使用 `watch()`
- 对追踪多个响应式来源使用 `watchEffect()`

```vue
<script setup lang="ts">
watch(
  () => props.userId,
  async (newId) => {
    user.value = await fetchUser(newId)
  },
  { immediate: true }
)
</script>
```

## Props 和 Emits

### 类型安全的 Props

始终使用 TypeScript 接口定义 props：

```vue
<script setup lang="ts">
interface Props {
  user: User
  isActive: boolean
  maxItems?: number
}

const props = defineProps<Props>()
</script>
```

### 类型安全的 Emits

始终使用 TypeScript 接口定义 emits：

```vue
<script setup lang="ts">
interface Emits {
  (e: 'select', id: string): void
  (e: 'update', data: UpdatePayload): void
  (e: 'delete', id: string): void
}

const emit = defineEmits<Emits>()
</script>
```

## 错误边界

Vue 3 需要通过 `errorCaptured` hook 或应用级错误处理器进行错误处理：

```ts
// 在 main.ts 中
const app = createApp(App)

app.config.errorHandler = (error, instance, info) => {
  // 记录错误
  console.error('Vue error:', error)
  // 显示用户友好的消息
  // 追踪错误分析
}
```

或组件级别：

```vue
<script setup lang="ts">
import { onErrorCaptured } from 'vue'

onErrorCaptured((error) => {
  // 处理子组件错误
  console.error('Child component error:', error)
  return false // 阻止错误传播
})
</script>
```

## 组件命名

- 组件名称：PascalCase（`UserProfile`、`Sidebar`）
- 自定义事件：kebab-case（`@user-select`、`@item-delete`）
- Composables：`use` 前缀（`useAuth`、`useDebounce`）
- 文件：kebab-case（`user-profile.vue`、`auth-composable.ts`）
