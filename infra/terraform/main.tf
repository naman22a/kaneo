locals {
  env = {
    stg = {
      instance_count = 1
    }
    prd = {
      instance_count = 1
    }
  }
  current = lookup(local.env, terraform.workspace, local.env["stg"])
}

module "ec2" {
  source = "./modules/ec2"
  env = terraform.workspace
  ec2_instance_count = local.current.instance_count
}
