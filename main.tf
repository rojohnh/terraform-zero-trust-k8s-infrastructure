# Sanitized EKS Cluster Provisioning 
resource "aws_eks_cluster" "secure_cluster" {
  name     = "dite-production-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids              = aws_subnet.private[*].id
    # Endpoint access restricted to internal corporate VPN routing
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  # KMS Encryption for Kubernetes Secrets at rest
  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = aws_kms_key.eks_secrets.arn
    }
  }
}
