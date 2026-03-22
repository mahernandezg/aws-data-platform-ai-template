# Vision

## Purpose

This document is the strategic north star of the `aws-data-platform-ai-template` repository.

It explains why this repository exists, what kind of AWS Data Platform it represents, which architecture choices it makes on purpose, and what good looks like when those choices are applied well.

It is written for:

- architects
- engineering managers
- senior engineers
- students and learners who want a readable enterprise reference

## Why This Repository Exists

Many data platform repositories begin as disconnected code samples, tool-specific experiments, or internal documentation fragments. That usually creates a system that is hard to govern, hard to teach, and hard to scale across teams.

This repository exists to solve a different problem.

It exists to provide a public, reusable, enterprise-grade reference for designing and accelerating an AWS Data Platform as a coherent architecture system. That means:

- architecture comes before tool preference
- component boundaries are explicit
- environment behavior is explicit
- data-layer ownership is explicit
- service selection is justified by responsibility, not fashion
- AI assistance is guided by architecture, not left to improvisation

The goal is not to publish every possible implementation. The goal is to make the repository understandable, opinionated, and reusable enough that teams can start from a strong architecture foundation instead of from ambiguity.

## What Kind of AWS Data Platform This Repository Represents

This repository represents a governed AWS Data Platform built for enterprise use.

Its architecture assumes:

- multiple teams
- multiple business domains
- multiple environments
- multiple AWS accounts
- multiple regions
- shared platform standards
- controlled autonomy for domain-aligned delivery teams

It is not a single-team analytics sandbox, not a monolithic central warehouse design, and not a collection of isolated project templates.

It is a platform model with five explicit architecture components:

- ISC for governed ingestion entry
- DP-EH for enterprise processing
- DP-SP for spoke or domain-aligned processing
- DCS for shared control, governance, and platform foundations
- DDC for governed distribution and consumption

This structure is designed to scale architecture clarity, not just infrastructure.

## Why Hub-and-Spoke

Hub-and-Spoke is the right model here because enterprise data platforms usually need two things at the same time:

- strong shared governance and reusable core services
- enough autonomy for domains and teams to move at useful speed

A fully centralized model often becomes a bottleneck. A fully decentralized model often becomes fragmented, inconsistent, and hard to govern.

Hub-and-Spoke creates a deliberate balance.

In this repository:

- the hub side provides shared governance, shared controls, enterprise processing patterns, and governed distribution behavior
- the spoke side allows bounded domain ownership where local transformation and Data Product preparation are justified

This is why the repository keeps component boundaries explicit. The platform should not force all work into one center, but it also should not let every team reinvent governance, Metadata, access, or distribution rules independently.

## Why Medallion

Medallion architecture is used here because the platform needs a clear language for data maturity and responsibility.

Without that language, teams often blur ingestion, standardization, transformation, and final Data Product exposure into one vague pipeline story. That makes ownership weak and architecture drift likely.

This repository makes Medallion mandatory because it improves clarity:

- ISC owns the Landing Zone only
- DP-EH owns enterprise Bronze, Silver, and Gold
- DP-SP owns spoke-aligned Bronze and Silver, plus constrained Gold for domain-specific outcomes
- DDC exposes Gold to consumers by default

That mapping matters because Medallion is not just a naming pattern here. It is a responsibility model.

It tells the repository where raw entry belongs, where standardization belongs, where enterprise-grade transformation belongs, where spoke-level transformation belongs, and where governed exposure belongs.

It also prevents a common failure mode: turning the consumption layer into a hidden processing layer.

## Why Apache Iceberg

Apache Iceberg is the standard Open Table Format in this repository because the platform needs a durable and modern table model from ISC onward.

Iceberg is a strong fit for this architecture because it supports the kind of behavior an enterprise data platform needs:

- ACID table behavior
- schema evolution
- partition evolution
- interoperable processing patterns across engines
- consistent table semantics across Bronze, Silver, and Gold

The point is not to promote a tool for its own sake. The point is to avoid a platform where every layer, workload, or team chooses a different table strategy and governance becomes inconsistent.

In this repository, Iceberg is part of architectural consistency. It gives the platform one durable standard for managed data from the moment data leaves the raw Landing Zone and enters governed Medallion processing.

## Why Multi-Account and Multi-Region

This repository treats multi-account and multi-region as architecture characteristics, not optional future improvements.

### Why Multi-Account

Enterprise platforms need controlled isolation.

That is why DEV, QA, PPRD, and PRD are isolated by AWS account, and why ISC, DP-EH, DP-SP, and DDC use explicit component-aligned account groups for the environments they support.

This improves:

- blast-radius control
- environment discipline
- clearer ownership boundaries
- safer progression toward production
- more realistic enterprise operating patterns

DIT is intentionally different. It is shared experimentation capacity only, through four shared accounts in eu-west-1. That preserves a low-friction place to learn and try ideas without pretending that experimentation is the same thing as controlled delivery.

### Why Multi-Region

Enterprise platforms also need region scope to be designed deliberately.

That is why the controlled platform operates in both `us-east-1` and `eu-west-1`, and why DIT is explicitly limited to `eu-west-1`.

This makes the architecture more realistic and more honest. Multi-region is not left as a vague aspiration. At the same time, this repository stays public and generic by avoiding undocumented claims about networking, disaster recovery internals, or organization-specific cloud foundation design.

## Why Redshift Is Limited to Serving

This repository allows Amazon Redshift, but only in a constrained role.

Redshift is used to store and serve final Gold Data Products when that serving pattern is justified. It is not the platform's main processing engine.

That choice is deliberate.

The platform wants processing to remain in the right layers and engines:

- Spark, Glue, and dbt for transformation
- Iceberg for governed Medallion data
- DDC for governed exposure
- Redshift for final serving where high-performance structured consumption is needed

This keeps the architecture honest. It prevents Redshift from silently becoming the place where Bronze, Silver, or enterprise transformation logic accumulates.

## Why AI-Assisted Engineering

This repository is designed for AI-assisted engineering because modern platform teams increasingly work with tools such as GitHub Copilot and Codex, and those tools are most useful when the repository gives them real structure.

AI is not treated here as a replacement for architecture. It is treated as an accelerator that becomes more reliable when:

- the vocabulary is controlled
- the architecture is explicit
- the responsibilities are explicit
- the environment model is explicit
- the prompts and instructions are opinionated

That is why this repository includes prompts, instruction files, templates, examples, and architecture documents as one system.

The intent is simple: a new engineer should be able to open the repository in VS Code, read the key files, and use AI assistance in a way that reinforces the architecture instead of weakening it.

## What "Good" Looks Like in This Repository

Good in this repository does not mean maximum complexity. It means architectural consistency that stays readable and reusable.

Good looks like:

- every major document reinforcing the same architecture story
- no contradictions between glossary, overview, component pages, environments, service mapping, prompts, instructions, templates, and examples
- clear separation between ISC, DP-EH, DP-SP, DCS, and DDC
- clear Medallion ownership from Landing Zone through Gold
- Apache Iceberg treated as a real platform standard, not a suggestion
- Redshift used only as a serving layer for final Gold Data Products
- IAM Roles only across human, runtime, and automation access
- multi-account and multi-region behavior stated explicitly
- public-safe language with no confidential enterprise assumptions
- AI-assisted outputs that follow the architecture instead of inventing a new one each time

Good also looks like readability. An architect should trust it, an engineering manager should understand why it matters, a senior engineer should be able to build from it, and a student should be able to learn from it without already knowing the whole field.

## What This Repository Is Trying to Become

The long-term goal is for this repository to feel like an accelerator kit for enterprise AWS data platforms.

That means it should provide:

- a strong architecture narrative
- a controlled vocabulary
- clear operating rules
- reusable prompts and instructions
- reusable templates
- realistic end-to-end examples

The repository should help teams move faster, but only by reducing ambiguity, not by lowering architectural standards.

## Summary

This repository exists to make enterprise AWS Data Platform architecture more coherent, more teachable, and more reusable.

Its core choices are intentional:

- Hub-and-Spoke for balance between governance and autonomy
- Medallion for layer clarity and ownership
- Apache Iceberg for a consistent governed table standard
- multi-account and multi-region design for realistic enterprise operation
- AI-assisted engineering for structured acceleration

If the repository continues to evolve in a way that keeps those choices explicit, consistent, and readable, it will achieve its purpose.
