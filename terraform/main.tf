resource "aws_iam_openid_connect_provider" "this" {
  url             = format("https://%s", var.oidc_url)
  client_id_list  = [var.oidc_client_id]
  thumbprint_list = [var.oidc_thumbprint]
}

resource "aws_iam_role" "this" {
  name = var.role_name
  assume_role_policy = data.aws_iam_policy_document.this.json

  tags = var.default_tags
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.this.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = format("%s:aud", var.oidc_url)
      values   = [var.oidc_client_id]
    }

    condition {
      test     = "StringLike"
      variable = format("%s:sub", var.oidc_url)
      values = [
        var.project_repository_condition
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each   = { for k, v in var.policy_arns : k => v }
  policy_arn = each.value
  role       = aws_iam_role.this.name
}