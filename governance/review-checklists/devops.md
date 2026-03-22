# DevOps Review Checklist

Use this checklist when reviewing Terraform, deployment patterns, account-model changes, region-model changes, or operational configuration.

- Does the change respect the controlled environment model?
- Does it respect the multi-account architecture?
- Does it respect the multi-region architecture?
- Does it preserve IAM Roles only?
- Are secrets handled safely?
- Are example infrastructure defaults reasonably hardened for a public template?
- Are naming and tagging patterns clear?
- Does the change avoid undocumented network or foundation assumptions?
- Does it remain generic and reusable?
