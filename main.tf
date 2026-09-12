resource "aws_instance" "web" {
  ami           = "ami-0f34c5ae932e6f0e4" # Replace with the desired AMI ID for your region
  instance_type = "t2.micro"              # Replace with the desired instance type

  tags = {
    Name = "MyEC2Instance" # Replace with your desired instance name
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              service httpd start
              echo "<html><body><h1>Hello from Terraform EC2</h1></body></html>" > /var/www/html/index.html
              EOF
}

### Use count ###

variable "instance_details" {
  description = "A map of instance details including AMI IDs and instance names."
  type = map(object({
    ami = string
    name = string
  }))
  default = {
    server1 = { ami = "ami-00beae93a2d981137", name = "Server1-awsami" }
    server2 = { ami = "ami-080e1f13689e07408", name = "Server2-ubuntu" }
    server3 = { ami = "ami-0fe630eb857a6ec83", name = "Server3-redhat" }
  }
}


resource "aws_instance" "servers" {
  count         = length(keys(var.instance_details))
  ami           = values(var.instance_details)[count.index].ami
  instance_type = "t2.micro"

  tags = {
    Name = values(var.instance_details)[count.index].name
  }
}

### for_each ###

# map     → identifies WHAT item it is
# object  → describes WHAT properties that item has 

variable "servers" {
  type = map(object({
    ami           = string
    instance_type = string
  }))

  default = {
    web = {
      ami           = "ami-0354c98ae10b02961"
      instance_type = "t3.micro"
    }

    app = {
      ami           = "ami-0b6d9d3d33ba97d99"
      instance_type = "t2.small"
    }

    backend = {
      ami           = "ami-0f8a61b66d1accaee"
      instance_type = "t2.nano"
    }
  }
}

resource "aws_instance" "appservers" {
  for_each = var.servers
  ami           = each.value.ami
  instance_type = each.value.instance_type
  tags = {
    Name = each.key
  }
  lifecycle {
    prevent_destroy = true
    ignore_changes = [ tags ]
    create_before_destroy = true
  }
}
