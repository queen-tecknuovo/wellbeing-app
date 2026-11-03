provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "webapp_server" {
  ami                    = "ami-00c631543d158ee40"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.webapp_sg.id]
  user_data              = file("userdata.sh")

}

resource "aws_security_group" "webapp_sg" {
  name = "wellbeing-app-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["93.115.182.28/32"]
  }

  ingress {
    from_port   = 5001
    to_port     = 5001
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
resource "aws_key_pair" "keypair" {
  key_name   = "wellbeing-key"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_ecr_repository" "wellbeing" {
  name = "wellbeing-app"
}