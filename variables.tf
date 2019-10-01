variable "alb_arn" {
  description = "ALB ARN to attach the waf auth to"
}

variable "x_manual_auth_secret" {
  description = "Secret to check in x-manual-auth header, if not specified will be generated randomly"
  default     = ""
}

variable "waf_name_alpha" {
  description = "Name for WAF resources. Note this needs to be alphanumeric only."
}

