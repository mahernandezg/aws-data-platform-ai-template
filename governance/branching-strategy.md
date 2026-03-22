# Branching Strategy

## Purpose

This document defines the default branching strategy for the `aws-data-platform-ai-template` repository.

Its purpose is to keep changes reviewable, traceable, and safe while the repository evolves as a public enterprise-grade architecture accelerator.

## Default Branch Flow

The default branch flow is:

- `feature/*` -> `dev` -> `main`

Interpretation:

- feature work starts in a dedicated branch
- reviewed work is merged into `dev`
- curated and stable repository progress is promoted from `dev` to `main`

## Branch Roles

### `main`

`main` is the public reference branch.

It should contain:

- stable architecture guidance
- stable governance guidance
- stable templates and examples
- reviewed repository-wide standards

Direct commits to `main` are not the default workflow.

### `dev`

`dev` is the integration branch for current repository evolution.

It should contain:

- reviewed feature work
- integrated documentation changes
- integrated template and example changes
- governance and architecture refinements under active iteration

### `feature/*`

Feature branches are the default place for implementation work.

Examples:

- `feature/update-service-mapping`
- `feature/add-redshift-example`
- `feature/config-machine-readable-model`

## Pull Request Expectations

Every non-trivial change should arrive through a pull request.

A pull request should:

- identify the scope of change
- state which architecture components are affected
- state which environments are affected when relevant
- state whether repository standards are affected
- explain any architecture or governance impact

## Change Types

### Documentation changes

Documentation-only changes still require review when they affect:

- architecture boundaries
- mandatory platform standards
- environment rules
- governance rules
- AI prompt or instruction behavior

### Template and example changes

Template and example changes require stronger review because they influence downstream implementation patterns.

### Architecture-standard changes

Changes to repository-wide standards should not be merged casually. They should be explained explicitly and reviewed against the glossary, overview, environments, service mapping, templates, examples, prompts, and instructions.

## Protected-Branch Discipline

The repository should assume the following discipline even if platform-level enforcement is configured elsewhere:

- no routine direct commits to `main`
- no unreviewed promotion from `feature/*` to `main`
- no architecture-standard changes without explicit review

## When to Use a Short-Lived Branch

Use a short-lived feature branch for:

- focused documentation fixes
- template improvements
- config updates
- prompt or instruction improvements

## When to Split Work

Split work into separate branches when:

- architecture and implementation changes are unrelated
- one change modifies repository-wide standards and another adds examples
- one change is risky or controversial and another is routine

## Review Before Promotion

Before promoting work from `dev` to `main`, confirm:

- repository standards are still consistent
- no architecture contradictions were introduced
- machine-readable config remains aligned to the docs
- templates and examples still reflect the same platform rules

## Summary

This repository uses a simple but disciplined branching model:

- work in `feature/*`
- integrate in `dev`
- publish stable progress in `main`

That model exists to preserve architecture consistency, review quality, and public-template trust.
