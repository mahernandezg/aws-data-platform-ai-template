# Data Engineering Review Checklist

Use this checklist when reviewing templates, examples, Glue jobs, PySpark jobs, dbt models, orchestration artifacts, or data-flow implementation patterns.

- Does the artifact state its architecture component?
- Does it align to the correct Medallion layer ownership?
- Does it preserve Apache Iceberg as the standard from ISC onward?
- Does it avoid positioning Redshift as the processing engine?
- Does it preserve DDC as the serving or exposure layer?
- Does it use IAM Roles rather than IAM Users or embedded credentials?
- Are inputs, outputs, and transformation steps readable?
- Are example defaults safe enough for a public enterprise template?
- Does the artifact teach the correct pattern, not just a runnable one?
