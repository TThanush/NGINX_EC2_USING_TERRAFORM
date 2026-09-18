output "ec2_public_ip" {
  value = aws_instance.example.public_ip
}
output "ec2_security_sg" {
  value = tolist(aws_instance.example.vpc_security_group_ids)[0]
}