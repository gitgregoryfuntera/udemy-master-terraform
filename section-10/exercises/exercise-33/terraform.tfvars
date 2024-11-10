project_name = "Project Name"

project = "project"

ec2_instance_count = 4

subnet_count = 2

ec2_instance_config_list = [
  {
    instance_type = "t2.micro",
    ami           = "ubuntu"
  },
  {
    instance_type = "t3.micro",
    ami           = "bitnami"
  }
]


ec2_instance_config_map = {
  ubuntu1 = {
    instance_type = "t2.micro"
    ami           = "ubuntu"
  }
  ubuntu2 = {
    instance_type = "t2.micro"
    ami           = "ubuntu"
  }
}

subnet_config_map = {
  subnet_1 = {
    cidr_block : "10.0.0.0/24"
  }

  subnet_2 = {
    cidr_block : "10.0.1.0/24"
  }
}
