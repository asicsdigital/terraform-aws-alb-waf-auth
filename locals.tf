locals {
  x_manual_auth_secret_target_string = coalesce(
    var.x_manual_auth_secret,
    random_id.default_x_manual_auth_secret.b64,
  )
}

