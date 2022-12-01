resource "aws_subnet" "public_1" {
  vpc_id = aws_vpc.main.id

  cidr_block = "192.168.0.0/18"

  availability_zone = "us-east-2a"

  map_public_ip_on_launch = true //every new instance deployed in this subnet will automatically get public IP(to join cluster)

  tags = {
    Name                        = "public-us-east-2a"
    "kubernetes.io/cluster/eks" = "shared" //helps EKS cluster discover this particular subnet amd use it

    # EKS can only use this subnet for load balancer creation if this is defined
    "kubernetes.io/role/elb"    = 1        //helps ELS to discover & create load balancers in those subnets
  }
}

resource "aws_subnet" "public_2" {
  vpc_id = aws_vpc.main.id

  cidr_block = "192.168.64.0/18"

  availability_zone = "us-east-2b"

  map_public_ip_on_launch = true //every new instance deployed in this subnet will automatically get public IP(to join cluster)

  tags = {
    Name                        = "public-us-east-2b"
    "kubernetes.io/cluster/eks" = "shared" //helps EKS cluster discover this particular subnet amd use it

    # EKS can only use this subnet for load balancer creation if this is defined
    "kubernetes.io/role/elb"    = 1        //helps ELS to discover & create load balancers in those subnets
  }
}

resource "aws_subnet" "private_1" {
  vpc_id = aws_vpc.main.id

  cidr_block = "192.168.128.0/18"

  availability_zone = "us-east-2a"

  map_public_ip_on_launch = true //every new instance deployed in this subnet will automatically get public IP(to join cluster)

  tags = {
    Name                              = "private-us-east-2a"
    "kubernetes.io/cluster/eks"       = "shared" //helps EKS cluster discover this particular subnet amd use it

    # EKS can only use this subnet for load balancer creation if this is defined
    "kubernetes.io/role/internal-elb" = 1        //helps ELS to discover & create load balancers in those subnets
  }
}

resource "aws_subnet" "private_2" {
  vpc_id = aws_vpc.main.id

  cidr_block = "192.168.192.0/18"

  availability_zone = "us-east-2b"

  map_public_ip_on_launch = true //every new instance deployed in this subnet will automatically get public IP(to join cluster)

  tags = {
    Name                              = "private-us-east-2b"
    "kubernetes.io/cluster/eks"       = "shared" //helps EKS cluster discover this particular subnet amd use it
    # EKS can only use this subnet for load balancer creation if this is defined
    "kubernetes.io/role/internal-elb" = 1        //helps EKS to discover & create load balancers in those subnets
  }
}