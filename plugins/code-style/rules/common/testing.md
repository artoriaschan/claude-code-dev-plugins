# 通用测试标准

> 适用于所有项目的测试原则。
> 注意：`~/.claude/rules/zh/testing.md` 中的全局规则定义了完整的测试标准。本文件提供与风格相关的测试要求的精简参考。

## 最低测试覆盖率：80%

所有项目应保持至少 80% 的代码覆盖率。

## 测试结构（AAA 模式）

使用 Arrange-Act-Assert 结构：

```typescript
test('returns empty array when no markets match query', () => {
  // Arrange（准备）
  const query = 'nonexistent'
  const markets = createMockMarkets()

  // Act（执行）
  const results = filterMarkets(markets, query)

  // Assert（断言）
  expect(results).toEqual([])
})
```

## 测试命名

使用描述性的名称来解释行为：

```typescript
// 好：描述场景
test('throws error when API key is missing', () => {})
test('falls back to substring search when Redis is unavailable', () => {})

// 差：模糊
test('test 1', () => {})
test('should work', () => {})
```

## 测试类型

- **单元测试**：单个函数、工具函数、组件
- **集成测试**：API 端点、数据库操作
- **E2E 测试**：关键用户流程

## 测试位置

- 测试放在项目根级别的 `__tests__/` 目录中
- 或与源文件放在一起，命名为 `file.test.ts`
