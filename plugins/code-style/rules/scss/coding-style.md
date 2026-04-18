---
paths:
  - "**/*.scss"
  - "**/*.sass"
---
# SCSS 编码风格

> 本文件在 [common/coding-style.md](../common/coding-style.md) 的基础上扩展了 SCSS 特定内容。

## 命名约定

| 元素 | 约定 | 示例 |
|---------|-----------|---------|
| CSS 类 | `kebab-case` | `.user-profile`、`.sidebar-item` |
| 变量 | `kebab-case` + `$` 前缀 | `$color-primary`、`$space-md` |
| Mixins | `kebab-case` | `@mixin flex-center` |
| 函数 | `kebab-case` | `@function rem()` |
| 占位符 | `kebab-case` + `%` 前缀 | `%card-base` |

```scss
// 错误：camelCase 类名
.userProfile { ... }
.user_card { ... }

// 正确：kebab-case 类名
.user-profile { ... }
.sidebar-item { ... }
```

```scss
// 错误：泛化的变量名
$blue: #3b82f6
$gray: #6b7280

// 正确：语义化的变量名
$color-primary: #3b82f6
$color-text-secondary: #6b7280
$space-md: 1rem
$radius-lg: 8px
```

## 组织

### 文件结构

```
styles/
├── tokens/
│   ├── colors.scss         # 调色板
│   ├── spacing.scss        # 间距比例
│   └── typography.scss     # 字号、字重
├── mixins/
│   ├── responsive.scss     # 媒体查询 mixins
│   └── utilities.scss      # 工具 mixins
├── globals/
│   ├── reset.scss          # CSS 重置
│   └── base.scss           # 基础元素样式
└── components/
    ├── user-profile.scss
    └── sidebar.scss
```

### SCSS 文件中的导入顺序

1. 变量/令牌
2. Mixins
3. 组件样式

```scss
// 组件 SCSS 文件
@use '../tokens/colors' as *;
@use '../tokens/spacing' as *;
@use '../mixins/responsive' as *;

.user-profile {
  color: $color-primary;
  padding: $space-md;
}
```

## 嵌套

- 限制嵌套深度最多为 **3 层**
- 使用 `&` 实现 BEM 风格的修饰符

```scss
// 错误：深层嵌套（4+ 层）
.page {
  .content {
    .user-list {
      .user {
        .avatar {
          img { ... }
        }
      }
    }
  }
}

// 正确：扁平结构，使用 &
.user-profile {
  padding: $space-md;

  &__header { ... }
  &__body { ... }
  &__footer { ... }

  &--active {
    border-color: $color-primary;
  }
}
```

## 变量和令牌

定义设计令牌，不要硬编码值：

```scss
:root {
  --color-surface: #ffffff;
  --color-text: #1a1a1a;
  --color-primary: #3b82f6;
  --space-sm: 0.5rem;
  --space-md: 1rem;
  --space-lg: 2rem;
  --text-base: 1rem;
  --text-lg: 1.25rem;
}
```

通过 CSS 自定义属性使用它们：

```scss
.card {
  background: var(--color-surface);
  padding: var(--space-md);
  font-size: var(--text-base);
}
```

## 媒体查询

使用一致的断点系统：

```scss
$breakpoints: (
  'sm': 640px,
  'md': 768px,
  'lg': 1024px,
  'xl': 1280px,
);

@mixin respond-to($breakpoint) {
  @media (min-width: map-get($breakpoints, $breakpoint)) {
    @content;
  }
}

// 使用
.user-grid {
  display: grid;
  gap: $space-md;
  grid-template-columns: 1fr;

  @include respond-to('md') {
    grid-template-columns: repeat(2, 1fr);
  }

  @include respond-to('lg') {
    grid-template-columns: repeat(3, 1fr);
  }
}
```
