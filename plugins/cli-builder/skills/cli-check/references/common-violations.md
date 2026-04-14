# Common Violations

Frequently found convention violations in TypeScript CLI projects and how to fix them.

## 1. ESM Import Without .js Extension

**Problem**: TypeScript imports omit `.js` extension in ESM projects.

```typescript
// Wrong
import { loadConfig } from './core/config'

// Correct
import { loadConfig } from './core/config.js'
```

**Fix**: Add `.js` extension to all relative imports. Run ESLint with `import/extensions` rule.

## 2. Double Quotes in Strings

**Problem**: Using double quotes where single quotes are required.

```typescript
// Wrong
const name = "my-tool"

// Correct
const name = 'my-tool'
```

**Fix**: Configure Prettier with `singleQuote: true`.

## 3. 2-Space Indentation

**Problem**: Default indentation is 2 spaces instead of required 4.

**Fix**: Configure Prettier with `tabWidth: 4`. Configure ESLint `indent` rule.

## 4. Using `.test.ts` Instead of `.spec.ts`

**Problem**: Test files named with `.test.ts` convention.

**Fix**: Rename all `*.test.ts` to `*.spec.ts`. Update vitest include patterns if needed.

## 5. Banned Dependencies

**Problem**: Project uses ts-node, jest, inquirer, or chalk 4.x.

**Fix**: Replace with recommended alternatives:
- ts-node → tsx
- jest → vitest
- inquirer → @clack/prompts
- chalk 4.x → chalk 5.x

## 6. Missing Barrel Exports

**Problem**: `src/index.ts` does not re-export all public modules, or Sheriff is not configured to enforce barrel exports.

**Fix**: Create proper barrel exports in `src/index.ts`. Add Sheriff rules to enforce.

## 7. No Pre-commit Hook

**Problem**: Missing Husky/lint-staged setup, allowing non-conforming code to be committed.

**Fix**: Add Husky 9.x, create `.husky/pre-commit` running lint-staged.

## 8. Changesets Not in Fixed Mode

**Problem**: Each package versions independently, or Changesets not configured.

**Fix**: Add `"fixed": ["@project-name/*"]` to `.changeset/config.json`.
