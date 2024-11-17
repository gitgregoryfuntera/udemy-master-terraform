data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners      = ["099720109477"] # Owner is Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.1"

  name                   = "public-ec2-instance-module"
  instance_type          = "t3.micro"
  ami                    = data.aws_ami.ubuntu_ami.id
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = element(module.vpc.public_subnets, 0)
}
