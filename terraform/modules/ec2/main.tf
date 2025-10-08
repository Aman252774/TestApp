resource "aws_instance" "ec2" {
  count                 = var.instance_config.instance_count
  ami                   = var.instance_config.ami_id
  instance_type         = var.instance_config.instance_type
  key_name              = var.instance_config.key_name
  associate_public_ip_address = true # Aapko ensure karna hoga ki EC2 public subnet me ho aur associate_public_ip_address = true ho.
  vpc_security_group_ids = [aws_security_group.ec2_sg.id] # Iske andar jo hmm security group define karenge. Wahi security group ec2 se attach hoga.

  tags = {
    Name = var.instance_config.instance_name
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"  # Amazon Linux ke liye "ec2-user"
    private_key = file("C:/Users/Aman Yadav/Downloads/Yadav-key.pem")  # Apna private key ka path
    host        = self.public_ip
    timeout     = "5m"      # Give instance time to boot up
  }

  provisioner "remote-exec" {
    inline = [
       "sudo yum update -y",
       "sudo amazon-linux-extras enable nginx1 -y",  # Enable Nginx repository
       "sudo yum install -y nginx",                  # Install Nginx
       "sudo systemctl enable nginx",                # Enable service
       "sudo systemctl start nginx"                  # Start service
    ]
  }
}

# 👇 Security group that allows SSH and HTTP
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-allow-ssh-http"
  description = "Allow SSH and HTTP"
  vpc_id      = var.instance_config.vpc_id
  ingress {          # Inbound rule.
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # for testing; later restrict to your IP
  }

  ingress {          # Inbound rule.
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
