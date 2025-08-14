resource "aws_security_group" "myinstance" {
  vpc_id      = module.vpc.vpc_id
  name        = "myinstance"
  description = "Allow traffic only from ELB"

  # Allow HTTP from the Load Balancer
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.elb-securitygroup.id]
  }

  # Allow all outbound traffic — needed for NAT Gateway access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "myinstance"
  }
}

resource "aws_security_group" "elb-securitygroup" {
  vpc_id      = module.vpc.vpc_id
  name        = "elb"
  description = "security group for load balancer"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elb"
  }
}

# -------------------------------
# Security Group for EKS Cluster
# -------------------------------
resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-cluster-sg"
  description = "EKS cluster security group"
  vpc_id      = data.terraform_remote_state.bootstrap.outputs.vpc_id

  # Allow all traffic from worker nodes
  ingress {
    description      = "Allow worker nodes to communicate with cluster"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    security_groups  = [aws_security_group.eks_node_sg.id]
  }

  # Allow cluster to communicate with nodes (all traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-cluster-sg"
  }
}

# -------------------------------
# Security Group for EKS Worker Nodes
# -------------------------------
resource "aws_security_group" "eks_node_sg" {
  name        = "eks-node-sg"
  description = "EKS worker node security group"
  vpc_id      = data.terraform_remote_state.bootstrap.outputs.vpc_id

  # Allow nodes to communicate with each other
  ingress {
    description     = "Allow nodes to communicate with each other"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    self            = true
  }

  # Allow nodes to communicate with the cluster control plane
  ingress {
    description      = "Allow nodes to reach cluster API"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    security_groups  = [aws_security_group.eks_cluster_sg.id]
  }

  # Allow internet access for nodes (optional, for pulling images)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-node-sg"
  }
}
