resource "aws_eks_cluster" "eks" {
  name     = "gitops-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  vpc_config {
    subnet_ids = [aws_subnet.main.id]
  }
}

resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.eks.name
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.main.id]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}
