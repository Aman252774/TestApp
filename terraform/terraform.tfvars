instance_config = {
  ami_id         = "ami-0f9708d1cd2cfee41"
  instance_type  = "t2.micro"
  instance_name  = "MyEC2Instance"
  aws_region     = "ap-south-1"
  instance_count = 3
  vpc_id         = "vpc-08828d2bf7d6d8f8a"
  key_name       = "Yadav-key" # AWS console me create kiya hua key pair name
}
