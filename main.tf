resource "aws_key_pair" "key_pair" {
  key_name   = "Thanush_key"
  public_key = file("C:/Users/dell/.ssh/terraform-key.pub")
}

module "ec2_install" {
  source = "./modules/ec2_creation"

  ami_val       = "ami-0b6d9d3d33ba97d99"
  key_pair_name = aws_key_pair.key_pair.key_name
  EC2_name      = "Practice"
  EC2_Size      = "t3.micro"
}

output "ec2_public_ip" {
  value = module.ec2_install.ec2_public_ip
}
output "ec2_SG" {
  value = module.ec2_install.ec2_security_sg
}

resource "null_resource" "executing_commands_on_server" {
  depends_on = [module.ec2_install]
  triggers = {
    always_run = timestamp()
  }

  provisioner "file" {
    source = "./index.html"
    destination = "/tmp/index.html"
    connection {
      type        = "ssh"
      host        = module.ec2_install.ec2_public_ip
      user        = "ubuntu"
      private_key = file("C:/Users/dell/.ssh/terraform-key")
    }
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = module.ec2_install.ec2_public_ip
      user        = "ubuntu"
      private_key = file("C:/Users/dell/.ssh/terraform-key")
    }
    inline = ["sudo apt update",
      "sudo apt install nginx -y",
      "sudo mv /tmp/index.html /var/www/html/index.nginx-debian.html",
      "sudo systemctl start nginx"
    ]
  }


}
/*
resource "aws_vpc_security_group_ingress_rule" "adding_ssh_to_the_SG" {
  depends_on        = [module.ec2_install]
  security_group_id = module.ec2_install.ec2_security_sg
  ip_protocol       = "tcp"
  from_port         = "22"
  to_port           = "22"
  cidr_ipv4         = "0.0.0.0/0"
}
*/
resource "aws_vpc_security_group_ingress_rule" "adding_http_to_the_SG" {

  depends_on = [module.ec2_install]

  security_group_id = module.ec2_install.ec2_security_sg

  ip_protocol = "tcp"

  from_port = 80
  to_port   = 80

  cidr_ipv4 = "0.0.0.0/0"
}