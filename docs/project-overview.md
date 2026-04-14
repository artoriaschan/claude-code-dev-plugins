# Project Overview

## What Is This Project

A personal plugin management project for Claude Code. It hosts custom plugins that extend Claude Code's capabilities for development workflows.

## Goals

1. **Reusable plugins**: Build plugins for recurring development tasks (CLI scaffolding, code review, deployment, etc.)
2. **Personal conventions**: Enforce consistent code styles and project structures across all generated projects
3. **Iterative improvement**: Plugins evolve based on daily usage — new skills and agents are added as needs arise

## Current State

One active plugin exists:

### cli-builder

TypeScript CLI tool builder with:
- **Interactive scaffolding**: Generates complete monorepo projects (pnpm + Commander + Zod + Chalk + tsup + Vitest)
- **Code style checking**: Validates projects against coding-plans-statusline conventions
- **Command template generation**: Creates individual command files with proper structure
- **Auto-validation**: Hooks check code style on file write and after subagent execution

## Design Decisions

### Single Root Manifest

All plugins share one `.claude-plugin/plugin.json` at the project root rather than each plugin having its own manifest. This simplifies local development — one `--plugin-dir` flag loads everything.

### Plugin Directory Structure

Plugins live under `plugins/<name>/` with all components (skills, agents, hooks) nested inside. The manifest points to these subdirectories via relative paths.

### Convention Reference

The `cli-builder` plugin derives its code conventions from the `coding-plans-statusline` project (a real CLI tool built with TypeScript ESM, Commander, Zod, etc.). These conventions are captured in `skills/cli-create/references/tech-stack.md` and enforced by `skills/cli-check`.

## Future Plans

- Add more plugins as development needs arise
- Potentially publish plugins to the Claude Code marketplace
