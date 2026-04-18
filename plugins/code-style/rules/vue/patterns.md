# Vue 模式

> Vue 项目的通用模式。

## Composables

使用 composables 封装可复用的逻辑：

```ts
// composables/use-fetch.ts
import { ref } from 'vue'

export function useFetch<T>(url: string) {
  const data = ref<T | null>(null)
  const error = ref<Error | null>(null)
  const isLoading = ref(false)

  async function execute() {
    isLoading.value = true
    try {
      const response = await fetch(url)
      data.value = await response.json()
    } catch (err) {
      error.value = err as Error
    } finally {
      isLoading.value = false
    }
  }

  return { data, error, isLoading, execute }
}
```

## Provide / Inject

使用 provide/inject 进行深层组件树通信：

```vue
<!-- 父组件 -->
<script setup lang="ts">
import { provide, ref } from 'vue'

const theme = ref('light')
provide('theme', theme)
</script>

<!-- 子组件（深层） -->
<script setup lang="ts">
import { inject } from 'vue'

const theme = inject<Ref<string>>('theme')
</script>
```

## Slots

使用 slots 实现灵活的组件组合：

```vue
<!-- Card.vue -->
<template>
  <div class="card">
    <header class="card-header">
      <slot name="header" />
    </header>
    <main class="card-body">
      <slot />
    </main>
    <footer class="card-footer">
      <slot name="footer" />
    </footer>
  </div>
</template>
```

## URL 作为状态

通过 router 将可共享的状态持久化到 URL 中：

```ts
// 使用 router query 参数处理筛选、分页等
const route = useRoute()
const router = useRouter()

const page = computed({
  get: () => Number(route.query.page) || 1,
  set: (val) => router.push({ query: { ...route.query, page: val } })
})
```
