terraform {
  backend "s3" {
    bucket = "terra-statefile-afcon"
    region = "us-east-1"
    key    = "terraform/multi-resources"
  }
}
