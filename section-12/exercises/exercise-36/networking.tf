
module "vpc_cidr" {
  source = "./modules/networking"
  vpc_config = {
    name       = "Custom Module VPC"
    cidr_block = "10.0.0.0/16"
  }

  subnet_config = {
    subnet_1 = {
      cidr_block = "10.0.0.0/24"
      az         = "ap-southeast-1a"
    }
    subnet_2 = {
      cidr_block = "10.0.1.0/24"
      az         = "ap-southeast-1b"
      public     = true
    }
  }
}
