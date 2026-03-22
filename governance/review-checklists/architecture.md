# Architecture Review Checklist

Use this checklist when reviewing architecture, design, service-mapping, glossary, environment, or repository-standard changes.

- Does the change preserve the Hub-and-Spoke model?
- Are ISC, DP-EH, DP-SP, DCS, and DDC still clearly separated?
- Are Medallion ownership boundaries explicit and correct?
- Does the change preserve DDC as distribution, not processing?
- Does the change preserve IAM Roles only?
- Does the change preserve Apache Iceberg from ISC onward?
- Does the change preserve Redshift as serving only?
- Does the change preserve multi-account and multi-region rules?
- If a standard changed, were all impacted artifacts updated consistently?
- Is the wording readable, precise, and public-safe?
