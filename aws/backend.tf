terraform {
  backend "s3" {
    bucket = "logicdesk.tfbackend"
    key    = "terraform/logicdesk.tfstate"
    region = "eu-west-1"
  }
}
