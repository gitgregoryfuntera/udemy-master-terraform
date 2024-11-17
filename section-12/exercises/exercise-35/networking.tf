module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.15.0"

  name = "public-modules"
  cidr = "10.0.0.0/16"

  azs = local.vpc.azs

  private_subnets = local.vpc.private_subnets
  public_subnets  = local.vpc.public_subnets

  tags = merge({},
    local.common_tags
  )
}
