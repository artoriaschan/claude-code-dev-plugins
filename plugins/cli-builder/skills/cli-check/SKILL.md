---
name: cli-check
description: This skill should be used when the user asks to "check CLI code style", "lint my CLI project", "verify code conventions", "check TypeScript CLI conventions", "audit coding style", "check if my CLI follows conventions", or mentions validating code style for TypeScript CLI projects. Validates TypeScript CLI projects against coding-plans-statusline code conventions.
version: 0.1.0
---

# CLI Code Style Checker

## Purpose

Validate an existing TypeScript CLI project against the coding-plans-statusline code conventions. Checks code style, project structure, dependency usage, and configuration compliance.

## Trigger Conditions

Activate when the user requests checking code style, linting conventions, or validating a CLI project against established standards.

## Workflow

### Step 1: Identify Project Root

Locate the project root by finding:
- `package.json` with `type: "module"` and pnpm workspace config
- `pnpm-workspace.yaml` or `pnpm-workspace.yml`
- `tsconfig.base.json` or `tsconfig.json`

If multiple candidates exist, ask the user which project to check.

### Step 2: Load Conventions Reference

Read `references/tech-stack.md` (from the cli-create skill at `../cli-create/references/tech-stack.md`) to obtain the full list of conventions to validate against.

### Step 3: Run Checks

Perform the following checks and report findings:

| Check | What to Verify | Severity |
|-------|----------------|----------|
| ESM compliance | `"type": "module"` in package.json | Critical |
| TypeScript config | Strict mode enabled, NodeNext resolution | Error |
| String style | Single quotes used | Warning |
| Indentation | 4-space indentation | Warning |
| Line width | No lines exceeding 100 characters | Warning |
| Barrel exports | Sheriff config present, barrel files used | Error |
| Test naming | `.spec.ts` convention for test files | Warning |
| Directory structure | `core/`, `commands/`, `domain/` conventions | Info |
| Dependencies | No banned deps (ts-node, jest, inquirer, chalk 4, oclif, Joi) | Error |
| Required deps | commander, zod, chalk 5.x present in CLI package | Error |
| Package manager | pnpm used (not npm/yarn) | Error |
| Changesets | Changesets configured in fixed mode | Info |
| Husky | Pre-commit hook with lint-staged | Info |
| Sheriff | Module boundary rules configured | Warning |

### Step 4: Generate Report

Output a structured report grouped by severity:

- **Critical**: Must fix, prevents project from working correctly
- **Error**: Violates established conventions
- **Warning**: Minor style deviation
- **Info**: Suggestion for improvement

Include specific file paths, line numbers, and suggested fixes for each finding.

### Step 5: Offer Auto-Fix

For fixable issues (string style, indentation, line width), offer to apply automatic corrections using Prettier and ESLint.

## Additional Resources

### Reference Files

- **`references/convention-checklist.md`** — Detailed checklist of all conventions with exact rules
- **`references/common-violations.md`** — Common violations found in real projects and how to fix them

### Examples

- **`examples/check-report.md`** — Example of a complete check report output
