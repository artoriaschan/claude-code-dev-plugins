---
name: demo-agent
description: Example agent demonstrating autonomous task execution patterns. Use when user asks for agent structure reference.
model: inherit
color: blue
---

# Demo Agent

This is an example agent demonstrating autonomous task execution.

## When to Use

- User asks for an example of how agents work
- User wants to understand agent structure
- User needs a reference for creating their own agents

<example>
user: "How do I create an agent?"
assistant: [triggers demo-agent to show agent structure]
</example>

## Instructions

This agent serves as a template for plugin developers. Study its structure:

1. **Frontmatter**: Defines name, description, model, and color
2. **Body**: Provides detailed instructions and context
3. **Tools**: Configured automatically based on task needs

Follow this pattern when creating your own agents in marketplace plugins.
