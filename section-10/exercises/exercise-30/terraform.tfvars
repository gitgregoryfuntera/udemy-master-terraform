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
