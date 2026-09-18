provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "example" {
  ami = var.ami_val
  key_name = var.key_pair_name
  instance_type = var.EC2_Size
  #subnet_id = var.subnet_id_val
  tags = {
    "name" = var.EC2_name
  }
}


