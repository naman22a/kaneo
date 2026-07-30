# Key Pair

resource "aws_key_pair" "deployer" {
  key_name   = "${var.env}-kaneo-terraform-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# VPC (default)

resource "aws_default_vpc" "default" {

}

# Security Group

resource "aws_security_group" "my_security_group" {
  name   = "${var.env}-kaneo-sg"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance

resource "aws_instance" "my_instance" {
  count = var.ec2_instance_count
  ami           = var.ec2_ami_id
  instance_type = var.ec2_instance_type

  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  key_name               = aws_key_pair.deployer.key_name

  # root storage (EBS)
  root_block_device {
    volume_size = var.ec2_volume_size
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.env}-${var.ec2_instance_name}"
    Environment = var.env
  }
}

resource "aws_ec2_instance_state" "my_instance_state" {
  count = var.ec2_instance_count
  instance_id = aws_instance.my_instance[count.index].id
  state = var.ec2_instance_state
}