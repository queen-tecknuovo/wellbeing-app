provider "aws" {
  region = "us-west-2"
}

resource "aws_ecs_cluster" "app_cluster" {
  name = "wellbeing-cluster"
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

resource "aws_ecr_repository" "wellbeing" {
  name = "wellbeing-app"
}