output "ec2_public_dns" {
  value = {
    for name, instance in aws_instance.my_instance :
    name => instance.public_dns
  }
}

output "ec2_public_ip" {
  value = {
    for name, instance in aws_instance.my_instance :
    name => instance.public_ip
  }
}
