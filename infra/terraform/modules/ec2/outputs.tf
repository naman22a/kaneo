output "public_dns" {
  value = {
    for name, instance in aws_instance.my_instance :
    name => instance.public_dns
  }
}

output "public_ips" {
  value = {
    for name, instance in aws_instance.my_instance :
    name => instance.public_ip
  }
}
