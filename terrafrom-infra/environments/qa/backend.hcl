terraform {
  backend "s3" {
    bucket       = "-terrmyaform-state-bucketrrrr"
    key          = "qa/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
