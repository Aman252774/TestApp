resource "aws_instance" "ec2" {
  ami           = var.instance_config.ami_id
  instance_type = var.instance_config.instance_type
  key_name      = var.instance_config.key_name   # yahan apna AWS key pair ka naam dena hai

  tags = {
    Name = var.instance_config.instance_name
  }

    provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"             # Amazon Linux ke liye "ec2-user"
    private_key = file("Downloads")    # apna private key ka path
    host        = self.public_ip
  }
}

