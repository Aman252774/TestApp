resource "aws_instance" "ec2" {
  count                 = var.instance_config.instance_count
  ami                   = var.instance_config.ami_id
  instance_type         = var.instance_config.instance_type
  key_name              = var.instance_config.key_name

  tags = {
    Name = var.instance_config.instance_name
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"  # Amazon Linux ke liye "ec2-user"
    private_key = file("C:/Users/Aman Yadav/Downloads/Yadav-key.pem")  # Apna private key ka path
    host        = self.public_ip
  }
}

