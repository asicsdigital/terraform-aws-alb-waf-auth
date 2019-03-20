# provide the secret, needed if it was randomly generated

output "x_manual_auth_target_string" {
  value       = "${local.x_manual_auth_secret_target_string}"
  description = "Secret that this WAF will check for in x-manual-auth header"
  sensitive   = true
}
