locals {
  env = {
    stg = {
      instance_count = 1
      instances = {
        worker-ubuntu = {
          ami = "ami-01a00762f46d584a1"
          user = "ubuntu",
          os_family = "ubuntu"
        }
      }
    }
    prd = {
      instance_count = 1
      instances = {
        worker-ubuntu = {
          ami = "ami-01a00762f46d584a1"
          user = "ubuntu",
          os_family = "ubuntu"
        }
      }
    }
  }
  current = lookup(local.env, terraform.workspace, local.env["stg"])
}

module "ec2" {
  source = "./modules/ec2"
  env = terraform.workspace
  ec2_instance_count = local.current.instance_count
  instances = local.current.instances
}
