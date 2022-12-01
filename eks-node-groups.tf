resource "aws_iam_role" "nodes_general" {
  name               = "eks-node-group-general"
  assume_role_policy = jsonencode({
    Version: "2012-10-17"
    Statement: [
      {
        Effect: "Allow",
        Principal: {
          "Service": "ec2.amazonaws.com"
        },
        Action: "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
  # It describes a couple of resources instances routetables, SGs, subnets, Vpcs, volumes, clusters etc
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
  # It assigns/unassigns(PrivateIps), deletes(Network Interfaces), describes(Instances), detachs, modifys Network Interfaces
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  # It helps download private images from private registry repository(ECR)
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes_general.name
}

resource "aws_eks_node_group" "node_general" {
  cluster_name = aws_eks_cluster.eks.name

  node_group_name = "noodes-general"

  # Amazon Resource Name of the IAM Role that provides permissions for the EKS Node
  node_role_arn = aws_iam_role.nodes_general.arn

  # Identifiers of the EC2 Subnets to associate with th eEKS Node Group.
  # These Subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME
  # (where CLUSTER_NAME is replaced with the name of the EKS Cluster).
  # Only private subnets to deploy worker nodes
  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  # Configuration block with scaling settings
  scaling_config {
    # Desired numbe of worker nodes.
    desired_size = 1

    # Maximim number of worker nodes.
    max_size = 1

    # Minimum number of worker nodes.
    min_size = 1
  }

  # Type pf AMI associated with the EKS Node Group
  #Valid values: AL2_X86_64, AL2_X86_64_GPU, AL2_ARM_64
  ami_type = "AL2_x86_64"

  # Type of capacity associated with the EKS Node Group
  # Valid values: ON_DEMAND, SPOT
  capacity_type = "SPOT"

  # Disk size in GiB for worker Nodes
  disk_size = 20

  #Force version update if existing pods are unable to be drained due to a pod disruption budget issue.
  force_update_version = false

  # List of instance types associated with EKS Node Group
  instance_types = ["t3.small"]

  labels = {
    role = "nodes-general"
  }

  # K8s Version
  version = "1.18"


  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]
}