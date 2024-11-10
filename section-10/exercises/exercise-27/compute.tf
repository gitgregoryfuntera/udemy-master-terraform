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


resource "aws_instance" "ec2_instance" {
  count         = var.ec2_instance_count
  ami           = data.aws_ami.ami.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.subnet[count.index % length(aws_subnet.subnet)].id
  root_block_device {
    delete_on_termination = true
    volume_size           = "20"
    volume_type           = "gp3"
  }

}
