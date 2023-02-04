variable "role_name" {
  description = "Role for CircleCI."
  type        = string
  default     = "circleci-oidc-tf"
}

variable "oidc_url" {
  description = "The issuer of the OIDC token."
  type        = string
  default     = "oidc.circleci.com/org/ORGANIZATION_ID"
}

variable "oidc_client_id" {
  description = "Custom audience"
  type        = string
  default     = "ORGANIZATION_ID"
}

variable "oidc_thumbprint" {
  description = "Thumbprint of the issuer."
  type        = string
  default     = "Thumbprint"
}

variable "project_repository_condition" {
  description = ""
  type        = string
  default = "org/ORGANIZATION_ID/project/PROJECT_ID/user/*"
}

variable "policy_arns" {
  description = "A list of policy ARNs to attach the role"
  type        = list(string)
  default     = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]
}

variable "default_tags" {
  description = "Default tags for AWS resources"
  type        = map(string)
  default     = {}
}