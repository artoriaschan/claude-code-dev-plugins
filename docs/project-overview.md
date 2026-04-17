# Project Overview

## What Is This Project

A Claude Code plugin marketplace. It hosts custom plugins for personal development workflows, distributed via the Claude Code marketplace under `artoriaschan/claude-code-dev-plugins`.

## Goals

1. **Reusable plugins**: Build plugins for recurring development tasks (CLI scaffolding, code review, deployment, etc.)
2. **Personal conventions**: Enforce consistent code styles and project structures across all generated projects
3. **Iterative improvement**: Plugins evolve based on daily usage — new skills and agents are added as needs arise

## Design Principles

### Per-Plugin Independence

Each plugin lives under `plugins/<name>/` with its own manifest. Plugins are independently developable, testable, and shareable.

### Auto-Discovery Over Explicit Registration

Skills and agents are auto-discovered from standard directories. Manifest paths override auto-discovery only when needed.

### Convention as Code

Coding conventions for generated projects are captured as rules and enforced automatically — not documented and forgotten.

## Status

- Plugins published to Claude Code marketplace: `artoriaschan/claude-code-dev-plugins`
- Lightweight skill definitions with detailed rules in `rules/` to avoid content duplication
- Add more plugins as development needs arise
