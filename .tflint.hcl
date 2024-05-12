plugin "terraform" {
    enabled = true
    preset  = "recommended"
}

#Todo : configure aws module linter with aws credentials
#       https://github.com/terraform-linters/tflint-ruleset-aws/blob/master/docs/configuration.md
#plugin "aws" {
#    enabled = true
#    version = "0.22.1"
#    source  = "github.com/terraform-linters/tflint-ruleset-aws"
#}