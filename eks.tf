resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster"

  #The policy that grants an entity permission to assume the role.
  # Used to access AWS resources that you might not normally have access to.
  # The role that Amazon EKS will use to creater AS resources for kubernetes clusters
  assume_role_policy = jsonencode({
    Version: "2012-10-17",
    Statement: [
      {
        Effect: "Allow",
        Principal: {
        Service: "eks.amazonaws.com"
        },
        Action: "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  # The role of the policy should be applied to
  role = aws_iam_role.eks_cluster.name

  # The ARN of the policy you want to apply
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "eks" {
  name = "eks"

  # The Amazon Resource name (ARN) of the IAM role that provides permissions for the Kubernetes control
  # plane to make calls to AWS API operations on your behalf
  role_arn = aws_iam_role.eks_cluster.arn

  # Desired Kubernetes master version
  version = "1.25"

  vpc_config {
    # Indicate whether or not the Amazon EKS Private API server endpoint is enabled
    endpoint_private_access = false # we dont have bastion host to access private endpoint, so

    # Indicate whether or not the Amazon EKS Private API server endpoint is enabled
    endpoint_public_access = true # we tell EKS to create public endpoint so we use our system to connect to it

    # Must be in at least 2 different availability zones
    subnet_ids = [
      aws_subnet.public_1.id, aws_subnet.public_2.id,
      aws_subnet.private_1.id, aws_subnet.private_2.id,
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy,
  ]
}

