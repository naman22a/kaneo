variable "ec2_instance_name" {
  description = "This variable holds EC2 instance name"
  default = "kaneo-server"
  type = string
}

variable "ec2_volume_size" {
  description = "This variable holds EC2 instance volume size"
  default = 10
  type = number
}

variable "ec2_instance_state" {
  description = "This variable holds EC2 instance state"
  default = "running"
  type = string
}

variable "env" {
  description = "This variable holds the environment"
  type = string
}

variable "ec2_ami_id" {
  description = "AMI ID for the EC2 instances"
  default = "ami-01a00762f46d584a1"
  type        = string
}

variable "ec2_instance_type" {
  description = "This variable holds EC2 instance type"
  default = "t3.micro"
  type        = string
}

variable "ec2_instance_count" {
  description = "This variable holds EC2 instance count"
  type = number
}