# Convention Checklist

Complete list of conventions enforced by cli-check.

## Project Structure

- [ ] Root `package.json` has `"type": "module"`
- [ ] Root `package.json` has `"private": true`
- [ ] `pnpm-workspace.yaml` exists with `packages: ['packages/*']`
- [ ] `tsconfig.base.json` exists at root
- [ ] `turbo.json` exists at root
- [ ] `vitest.config.ts` + `vitest.workspace.ts` exist at root
- [ ] `eslint.config.js` (flat config) exists
- [ ] `sheriff.config.ts` exists
- [ ] `.husky/pre-commit` with lint-staged
- [ ] `.gitignore` includes `node_modules/`, `dist/`, `types/`

## Package-Level

- [ ] Each package has `"type": "module"` in package.json
- [ ] Each package extends `../../tsconfig.base.json`
- [ ] Each package has `tsconfig.build.json`
- [ ] CLI package has `bin` field
- [ ] Barrel exports from `src/index.ts`
- [ ] No circular dependencies between packages

## Code Style

- [ ] Single quotes for strings
- [ ] 4-space indentation
- [ ] No lines exceeding 100 characters
- [ ] `.spec.ts` for test files (not `.test.ts`)
- [ ] `.js` extension in relative imports (ESM requirement)
- [ ] No `require()` calls — only `import`

## Dependencies

### Required (in CLI package)

- commander
- zod
- chalk (5.x)

### Banned

- ts-node → use tsx
- jest → use vitest
- inquirer → use @clack/prompts
- chalk (4.x) → use chalk 5.x
- oclif → use commander
- Joi → use zod
- npm/yarn workspaces → use pnpm

## Git Hooks

- [ ] Husky 9.x configured
- [ ] Pre-commit hook runs lint-staged
- [ ] lint-staged covers `*.{ts,tsx}` and `*.{json,md}`

## Version Management

- [ ] Changesets installed
- [ ] `.changeset/config.json` with `"access": "public"` and fixed mode
- [ ] `pnpm changeset` script available
- [ ] Release workflow configured
