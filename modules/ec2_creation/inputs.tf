variable "ami_val" {
  description = "used to get the input of ami"
}

variable "key_pair_name" {
  description = "used to assign the key pair"
}
/*
variable "subnet_id_val" {
  description = "used to assign the vm in an particular subnet"
}
*/

variable "EC2_name" {
  description = "will create a tag called name with the ec2"
}

variable "EC2_Size" {
    description = "please mention the size of the vm"
  
}