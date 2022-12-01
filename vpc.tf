resource "aws_vpc" "main" {
  cidr_block       = "192.168.0.0/16" //vpc cidr block
  instance_tenancy = "default"        //makes instances shared on the host i.e you cand do dedicated, shared etc

  //these 2 are required by EKS
  enable_dns_support   = true
  enable_dns_hostnames = true

  enable_classiclink = false

  enable_classiclink_dns_support = false

  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "main"
  }

}
output "vpc_id" {
  value       = aws_vpc.main.id
  description = "vpc id"
  sensitive   = false //setting an output value as sensitive prevents terraform from showing its value in "plan" and "apply"
}