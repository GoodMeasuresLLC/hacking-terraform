terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

# production connect instance:
# 03103f71-db62-4f61-9432-4bfae356b3e3
# first contact flow:
# 68920181-fa8e-4685-9aa5-4c4b811036e2
# S3 bucket for call recordings
# kinesis stream for contact trace records
# lambda functions, about 8. with titles like:
# arn:aws:lambda:us-east-1:201706955376:function:retrieve_development_contact_info
# arn:aws:lambda:us-east-1:201706955376:function:CheckHoliday
# approved domains: production && beta
# a whole bunch of contact flows

resource "aws_connect_instance" "connect" {
  identity_management_type = "CONNECT_MANAGED"
  inbound_calls_enabled    = true
  instance_alias           = var.instance_alias
  outbound_calls_enabled   = true
  auto_resolve_best_voices_enabled = false
  contact_flow_logs_enabled = true
  early_media_enabled = false
}
