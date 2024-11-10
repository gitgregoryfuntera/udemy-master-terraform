data "aws_ami" "ubuntu" {
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

data "aws_ami" "bitnami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["bitnami-nginx-1.27.2-*-linux-debian-12-x86_64-hvm-ebs-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "ec2_instance" {
  for_each      = var.ec2_instance_config_map
  ami           = local.ami_ids[each.value.ami]
  instance_type = each.value.instance_type
  subnet_id     = aws_subnet.subnet[each.value.subnet_key].id
}
