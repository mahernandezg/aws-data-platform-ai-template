# Enterprise Data Processing Framework (EDPF) — Roadmap

## 🎯 Objective
Build a metadata-driven, event-driven, enterprise-grade Data Processing Framework aligned with the AWS Hub-and-Spoke Data Platform architecture.

---

# 🧱 PHASE 1 — Framework Definition (FOUNDATION)

## Core Architecture
- Define EDPF as centralized control plane (DCS / DP-EH aligned)
- Define separation: Control Plane vs Runtime vs Developer Layer
- Define processing boundaries: ISC, DP-EH, DP-SP, DDC
- Formalize Iceberg-first processing strategy
- Formalize Event-driven architecture (S3 → EventBridge → Step Functions)

## Framework Contracts
- Dataset contract definition
- Pipeline contract definition
- Run control contract definition
- Event routing contract
- Governance contract (DQ, RI, PII, lineage)
- Engine selection policy

---

# 🧾 PHASE 2 — Metadata & Control Plane

## Metadata Model
- Dataset Registry (dataset_id, domain, classification, ownership)
- Pipeline Registry (processing patterns, merge strategy, dependencies)
- Schema Registry (source, canonical, serving)
- Governance Registry (DQ rules, PII rules, RI rules)
- Engine Policy Registry
- SLA & Observability metadata

## Runtime Control
- Run state tracking (run_id, watermark, status)
- Snapshot tracking (Iceberg snapshot references)
- Retry and failure handling model
- Idempotency guarantees

## Storage Strategy
- Git-based metadata (design-time)
- DynamoDB/Aurora (runtime state)
- S3 (config distribution)

---

# ⚡ PHASE 3 — Event-Driven Orchestration

## Event Layer
- S3 event standardization
- EventBridge routing rules
- Dataset resolution logic (Lambda router)

## Orchestration
- Step Functions standard workflows
- Pipeline lifecycle states:
  - Pre-validation
  - Execution
  - Post-validation
  - Publish

## Failure Strategy
- Fail-fast policy
- Dead-letter / quarantine zone
- Retry strategy (configurable)

---

# ⚙️ PHASE 4 — Processing Runtime

## Engine Adapters
- Glue Spark adapter
- Spark (EMR/Serverless) adapter
- dbt adapter

## Processing Patterns
- ISC → Bronze (standardization)
- Bronze → Silver (harmonization/unification)
- Silver → Gold (business modeling)
- Snapshot-diff pattern
- CDC pattern
- Multi-source unification pattern

## Core Capabilities
- Schema enforcement
- Deduplication
- Merge (insert/update/delete)
- Partitioning strategy
- Late-arriving data handling

---

# 🔁 PHASE 5 — Incremental Processing

## Standard Models
- Append-only
- Upsert (merge-on-read via Iceberg)
- Delete propagation
- Snapshot diff
- CDC ingestion

## Controls
- Deterministic key strategy
- Watermark tracking
- Idempotent reprocessing
- Conflict resolution rules
- Source precedence rules

---

# 🛡️ PHASE 6 — Governance by Design

## Data Quality
- Bronze: schema + technical validation
- Silver: business validation + deduplication
- Gold: RI + publishability

## PII Handling
- Masking
- Hashing
- Tokenization
- Drop/retain policies
- Layer-based enforcement

## Lineage
- OpenLineage integration
- Dataset-level lineage
- Column-level lineage (future)
- Run-level lineage tracking

## Access & Security
- Lake Formation tags
- IAM Roles enforcement
- Data classification-driven policies

---

# 📊 PHASE 7 — Observability & Reliability

## Metrics
- Row counts (in/out)
- DQ scores
- Latency
- SLA adherence

## Monitoring
- CloudWatch dashboards
- Alerting rules
- Failure notifications

## Audit
- Run history tracking
- Data change tracking
- Compliance logs

---

# 👨‍💻 PHASE 8 — Developer Experience

## Scaffolding
- New dataset template generator
- Pipeline template generator
- DQ/PII template generator

## Tooling
- CLI for dataset onboarding
- Local validation tool
- Contract testing framework

## Documentation
- Pattern catalog
- Example pipelines
- Decision trees (engine selection, patterns)

---

# 🧪 PHASE 9 — Reference Implementations

## Example Pipelines
- ISC → Bronze incremental ingestion
- Bronze → Silver multi-country unification
- Silver → Gold business KPI dataset

## Advanced Examples
- CDC pipeline
- Snapshot diff pipeline
- Multi-ERP harmonization

---

# 🚀 PHASE 10 — Enterprise Hardening

## Performance
- Partition optimization
- File compaction
- Spark optimization
- Adaptive query execution

## Scalability
- Multi-region execution strategy
- Cross-account orchestration

## FinOps
- Cost attribution
- Chargeback model
- Resource optimization policies

---

# 🧠 PHASE 11 — AI & Future Extensions

## AI Integration
- AI agents accessing Gold (default)
- Controlled access to Bronze/Silver
- Feature store integration

## Advanced Capabilities
- Self-healing pipelines
- Anomaly detection in data pipelines
- Automated optimization

---

# 📌 FINAL PRINCIPLES

- Metadata-first, not code-first
- Event-driven by default
- Iceberg as system of record
- Governance is mandatory, not optional
- One standardized way to build pipelines
- Separation of control plane and execution
- Designed for both junior and senior developers

---

# 🧭 NEXT STEP

Start with:

1. Metadata contracts (dataset, pipeline, run)
2. Event routing contract
3. First end-to-end reference pipeline (ISC → Bronze)

This will unlock the entire framework.
