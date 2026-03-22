# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: DCS Terraform starter module that creates one IAM role-only access pattern for platform workloads.

locals {
  name_prefix = "${var.project}-${var.component}-${var.environment}"

  standard_tags = {
    repository            = "aws-data-platform-ai-template"
    architecture_component = upper(var.component)
    environment           = upper(var.environment)
    managed_by            = "terraform"
    template_family       = "terraform"
  }

  merged_tags = merge(local.standard_tags, var.tags)
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    sid    = "AllowTrustedPrincipals"
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.assume_role_principals
    }
  }
}

resource "aws_iam_role" "this" {
  name               = "${local.name_prefix}-${var.role_purpose}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  description        = "IAM role-only starter for ${upper(var.component)} in ${upper(var.environment)}."
  tags               = local.merged_tags
}

resource "aws_iam_role_policy" "inline" {
  count = var.inline_policy_json == null ? 0 : 1

  name   = "${local.name_prefix}-${var.role_purpose}-inline"
  role   = aws_iam_role.this.id
  policy = var.inline_policy_json
}

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = toset(var.managed_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}
