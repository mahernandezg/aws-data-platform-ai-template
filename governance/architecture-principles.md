# Architecture Principles

## Purpose

This document defines the architecture principles that guide changes across the repository.

These principles are not optional style preferences. They are the criteria used to decide whether a new document, template, example, prompt, or configuration artifact fits the repository.

## Principles

### Architecture First

The repository must behave as a coherent architecture system, not as a random set of files.

### Explicit Boundaries

ISC, DP-EH, DP-SP, DCS, and DDC must remain distinct in mission, responsibility, and language.

### Governance by Design

Governance, access control, Metadata, lineage, and Observability must be designed into the platform model, not added after the fact.

### Reuse Before Duplication

Shared patterns should be provided once and reused, not reinvented independently across examples and templates.

### Medallion Is Mandatory

Landing Zone, Bronze, Silver, and Gold are required architecture concepts in this repository, not optional labels.

### Consumption Is Not Processing

DDC exists for governed exposure and serving. It must not drift into a general processing layer.

### Public and Generic by Default

The repository must remain safe for public sharing and reusable by downstream adopters.

### AI Must Reinforce Architecture

Prompts, instructions, templates, and config should make AI-assisted outputs more consistent with the architecture, not less.
