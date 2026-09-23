# AGENTS.md

# Purpose

This repository contains an ASP.NET Core Razor web application.

When making changes:

- Preserve existing architecture and conventions.
- Prefer small, focused changes.
- Avoid introducing new frameworks or dependencies unless requested.
- Follow existing coding patterns before introducing new ones.

# Technology Stack

- ASP.NET Core
- Razor Pages and/or MVC
- Entity Framework Core
- Dependency Injection
- Configuration via appsettings.json and environment variables

# General Principles

- Understand before modifying.
- Prefer consistency over innovation.
- Minimize the scope of changes.
- Keep solutions simple and maintainable.
- Do not rewrite working code without a clear benefit.

# Code Quality

- Follow existing naming conventions.
- Prefer strongly typed models.
- Avoid duplicated code.
- Keep methods focused on a single responsibility.
- Use async APIs when available.

# Razor Pages

When modifying Razor Pages:

- Keep page logic in PageModels.
- Keep business logic out of Razor views.
- Keep views focused on presentation.
- Prefer model binding over manual request parsing.

# MVC Controllers

When modifying MVC controllers:

- Keep controllers thin.
- Place business logic in services.
- Return appropriate IActionResult types.
- Use dependency injection.

# Entity Framework

- Prefer LINQ over raw SQL.
- Avoid N+1 query patterns.
- Use eager loading only when required.
- Do not introduce breaking schema changes unless explicitly requested.
- Create migrations when schema changes are required.

# Dependency Injection

- Register services through the existing DI system.
- Avoid service locators.
- Avoid static application state.

# Configuration

- Use configuration providers.
- Do not hardcode secrets.
- Read settings through IConfiguration or strongly typed options.

# Security

- Never hardcode credentials.
- Never commit secrets.
- Validate all user input.
- Prefer parameterized database access.
- Respect authorization requirements.
- Preserve existing authentication flows.

# Logging

- Use the existing logging framework.
- Log useful operational information.
- Do not log secrets, passwords, tokens, or personal data.

# Frontend

- Reuse existing CSS and JavaScript patterns.
- Minimize JavaScript when server-side rendering is sufficient.
- Preserve accessibility where possible.
- Avoid unnecessary UI redesigns.

# Database Changes

Before making database changes:

1. Inspect existing migrations.
2. Inspect entity relationships.
3. Verify backward compatibility.
4. Create migrations when needed.

Do not modify migration history.

# Testing

When changing code:

- Update existing tests when required.
- Add tests for new business logic.
- Do not remove tests without justification.

# File Handling

- Prefer modifying existing files over creating new ones.
- Keep project structure consistent.
- Do not introduce large-scale refactorings unless requested.

# Analysis Workflow

1. Understand the requirement.
2. Inspect affected files.
3. Identify existing patterns.
4. Implement the smallest viable change.
5. Verify build impact.
6. Verify runtime impact.
7. Summarize changes made.

# Expected Output

For implementation tasks:

- Explain the root cause.
- Explain the proposed change.
- Identify affected files.
- Keep changes minimal.

For review tasks:

- Identify risks.
- Identify bugs.
- Identify maintainability concerns.
- Provide actionable recommendations.

# General Principle

Understand first.
Change second.
Verify third.
Refactor only when necessary.