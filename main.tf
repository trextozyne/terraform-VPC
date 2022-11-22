provider "aws" {
  region = "us-east-2"
}

//variable "subnet_cidr_block" {
//  description = "Subnet Cidr Block"
//
//}

variable "cidr_blocks" {
  description = "List of cidr blocks"
  type = list(object({
    cidr_block = string
    name = string
  }))
}

//variable "environment" {
//  description = "deployment environment"
//}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.cidr_blocks[0].cidr_block
  tags = {
    Name: var.cidr_blocks[0].name
  }
}

variable "avail_zone" {}

resource "aws_subnet" "dev-subnet-1" {
  cidr_block = var.cidr_blocks[1].cidr_block
  availability_zone = var.avail_zone
  vpc_id = aws_vpc.development-vpc.id
  tags = {
     Name: var.cidr_blocks[1].name
  }
}

data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
  cidr_block = "172.31.48.0/20"
  availability_zone = "us-east-2a"
  vpc_id = data.aws_vpc.existing_vpc.id
  tags = {
    Name: "subnet-2-dev"
  }
}

output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
  value = aws_subnet.dev-subnet-1.id
}