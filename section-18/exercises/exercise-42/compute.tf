data "aws_ami" "ami" {
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

resource "aws_instance" "this" {
  ami           = data.aws_ami.ami.id
  instance_type = var.ec2_instance_type
  tags = {
    Name = "terraform cloud"
  }
}
