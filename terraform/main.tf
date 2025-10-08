module "ec2" {
  source = "./modules/ec2"

  instance_config = {
    ami_id         = var.instance_config.ami_id
    instance_type  = var.instance_config.instance_type
    instance_name  = var.instance_config.instance_name
    instance_count = var.instance_config.instance_count
    key_name       = var.instance_config.key_name
     vpc_id         = var.instance_config.vpc_id   # ✅ add this line
    aws_region     = var.instance_config.aws_region # ✅ region bhi pass karo
  }
}

