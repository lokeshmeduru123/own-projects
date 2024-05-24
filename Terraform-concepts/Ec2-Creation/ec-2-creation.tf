resource "aws_instance" "ansible" {
  ami = "ami-090252cbe067a9e58"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

tags = {
    Name = "ansible"
    CreatedBy = "lokesh"
  }

}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh port"
  
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }

  tags = {
    Name = "allow_ssh"
    CreatedBy = "lokesh"
  }
}

