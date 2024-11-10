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
  count         = length(var.ec2_instance_config_list)
  ami           = local.ami_ids[var.ec2_instance_config_list[count.index].ami]
  instance_type = var.ec2_instance_config_list[count.index].instance_type
  subnet_id     = aws_subnet.subnet[count.index % length(aws_subnet.subnet)].id

}
