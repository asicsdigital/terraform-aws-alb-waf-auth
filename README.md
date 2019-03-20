# terraform-aws-alb-waf-auth

This creates a WAF to require a certain string in a header to allow traffic to an ALB.

Use it for when you don't control the application code but want to add authentication.

Note it's not true basic auth because the WAF can't send a custom unauthorized page.


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alb\_arn | ALB ARN to attach the waf auth to | string | n/a | yes |
| waf\_name\_alpha | Name for WAF resources. Note this needs to be alphanumeric only. | string | n/a | yes |
| x\_manual\_auth\_secret | Secret to check in x-manual-auth header, if not specified will be generated randomly | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| x\_manual\_auth\_target\_string | Secret that this WAF will check for in x-manual-auth header |

## Usage

If specifying the secret:

```hcl
module "waf_auth" {
  source               = "github.com/asicsdigital/terraform-aws-alb-waf-auth?ref=v0.0.1"
  alb_arn              = "<alb arn here>"
  waf_name_alpha       = "<some alphabetical string here>"
  x_manual_auth_secret = "<your secret here>"
}
```

Or, not specifying secret:

````hcl
module "waf_auth" {
  source         = "github.com/asicsdigital/terraform-aws-alb-waf-auth?ref=v0.0.1"
  alb_arn        = "<alb arn here>"
  waf_name_alpha = "<some alphabetical string here>"
}

output "x_manual_auth_secret" {
  value = "${module.waf_auth.x_manual_auth_target_string}"
}
```
