resource "local_file" "my_hosts_file" {
  content = templatefile("${path.module}/../../templates/inventory.tpl", {
    instances = {
      for name, instance in aws_instance.my_instance : name => {
        public_ip = instance.public_ip
        user      = var.instances[name].user
      }
    }
    private_key = "/home/naman/.ssh/id_rsa"
  })

  filename        = abspath("${path.module}/../../../ansible/${var.env}/hosts")
  file_permission = "0644"
}
