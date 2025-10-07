variable "instance_config" {
  type = object({
    ami_id         = string
    instance_type  = string
    instance_name  = string
    aws_region     = string
    instance_count = number
    key_name       = string
  })
}
