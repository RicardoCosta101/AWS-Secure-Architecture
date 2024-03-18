#====================================================================================
# AMI that will be used (debian)
variable "ec2_ami" {
  default = "ami-058bd2d568351da34"
}

#====================================================================================
# Instance type that will be used
variable "instance_type" {
  default = "t2.micro"
}