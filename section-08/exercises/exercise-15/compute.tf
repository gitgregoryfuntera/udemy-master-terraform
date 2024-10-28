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

resource "aws_instance" "ec2" {
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"
  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_volum_config.volume_size
    volume_type           = var.ec2_volum_config.volume_type
  }

  tags = merge(var.tags, {
    ManangedBy = "Terraform"
  })
}
