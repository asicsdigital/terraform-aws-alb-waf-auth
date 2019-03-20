locals {
  x_manual_auth_secret_target_string = "${coalesce(var.x_manual_auth_secret, random_id.default_x_manual_auth_secret.b64)}"
}

# create a random_id, note it will not be used if the input x_manual_auth_secret was specified
resource "random_id" "default_x_manual_auth_secret" {
  byte_length = 32
}

resource "aws_wafregional_byte_match_set" "byte_match" {
  name = "${var.waf_name_alpha}ByteMatch"

  byte_match_tuples {
    "field_to_match" {
      type = "HEADER"
      data = "x-manual-auth"
    }

    positional_constraint = "EXACTLY"
    text_transformation   = "NONE"
    target_string         = "${local.x_manual_auth_secret_target_string}"
  }
}

resource "aws_wafregional_rule" "auth_rule" {
  metric_name = "${var.waf_name_alpha}Rule"
  name        = "${var.waf_name_alpha}Rule"

  predicate {
    data_id = "${aws_wafregional_byte_match_set.byte_match.id}"
    negated = false
    type    = "ByteMatch"
  }
}

resource "aws_wafregional_web_acl" "auth_acl" {
  "default_action" {
    type = "BLOCK"
  }

  metric_name = "${var.waf_name_alpha}ACL"
  name        = "${var.waf_name_alpha}ACL"

  rule {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = "${aws_wafregional_rule.auth_rule.id}"
  }
}

resource "aws_wafregional_web_acl_association" "alb_association" {
  resource_arn = "${var.alb_arn}"
  web_acl_id   = "${aws_wafregional_web_acl.auth_acl.id}"
}
