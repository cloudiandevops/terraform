resource "aws_instance" "webapp" {
  ami           = "ami-0aebec83a182ea7ea" # Replace with a valid AMI ID
  instance_type = "t2.micro"
  key_name      = aws_key_pair.appserver.key_name
  security_groups = [aws_security_group.ssh.name]

  provisioner "remote-exec" {
    inline = [
      "sudo yum update",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user" # Replace with the correct user for your AMI
      private_key = file("./appserver.pem")
    }
  }
  provisioner "local-exec" {
    command = "echo 'EC2 Public IP: ${self.public_ip}' > ./ec2_public_ip.txt"
  }
  tags = {
    Name = "webserver"
  }

}
