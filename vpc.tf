# Sanitized VPC Blueprint for Zero-Trust Networking
resource "aws_vpc" "enterprise_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { Name = "dite-zero-trust-vpc" }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.enterprise_vpc.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]
  # CRITICAL: No public IPs assigned to infrastructure nodes
  map_public_ip_on_launch = false 
}

resource "aws_nat_gateway" "secure_outbound" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
}
