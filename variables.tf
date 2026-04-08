variable "aws_region" { default = "ap-southeast-1" }
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "private_subnets" { default = ["10.0.1.0/24", "10.0.2.0/24"] }
variable "azs" { default = ["ap-southeast-1a", "ap-southeast-1b"] }
