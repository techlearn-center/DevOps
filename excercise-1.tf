provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_first_ec2" {
  ami                    = "ami-00b8917ae86a424c9"
  instance_type          = "t2.micro"
  key_name               = "my-multi-tier-key"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = ["sg-0dd2ac51aab7b4ab2"]
  subnet_id              = "subnet-0e5e301ebe4d5d6fb"
  tags = {
    Name = "Terraform-Instance"
  }

}
