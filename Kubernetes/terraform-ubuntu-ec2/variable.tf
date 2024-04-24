variable "region_name" {
  type    = string
  default = "us-east-1"
}

variable "ami" {
  type    = string
  default = "ami-00b8917ae86a424c9"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "vpc-sg" {
  type    = list(any)
  default = ["sg-03279de1f6ebda0d9"]
}

variable "zone" {
  type    = string
  default = "us-east-1a"
}


variable "user" {
  default = "ubuntu"

}
