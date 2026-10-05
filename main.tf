terraform {
  required_providers {
    http = {
      source  = "terraform-aws-modules/http"
      version = "2.4.1"
    }
  }
}

provider "http" {
  # Configuration options
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "ec2-instance"

  instance_type = "t3.micro"
  key_name      = "user1"
  monitoring    = true
  subnet_id     = ""

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
