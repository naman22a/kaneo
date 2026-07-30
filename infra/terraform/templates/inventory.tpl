[servers]
%{ for name, instance in instances ~}
${name} ansible_host=${instance.public_ip} ansible_user=${instance.user}
%{ endfor ~}

[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_private_key_file=${private_key}
ansible_host_key_checking=false
