provider "aws" {
  profile = "terraform"
  region  = "us-east-2"
}

//optionally, store state locally no remote storage(state data are sheared btn all members of team) i.e S3, etcd,
//Google cloud, Terraform cloud, Hashicorp consul, Azure blob storage

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.21"
    }
  }
}