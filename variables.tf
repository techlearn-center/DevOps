variable "region" {
  default = "us-east-1"
}

variable "ami" {
  type = map(any)
  default = {
    us-east-1 = "ami-00b8917ae86a424c9"
  }
}

variable "zone-1" {
  default = "us-east-1a"
}

variable "zone-2" {
  default = "us-east-1b"
}

variable "zone-3" {
  default = "us-east-1c"
}

variable "instance-type" {
  default = "t2.micro"
}

variable "vpc-sg" {
  type    = list(any)
  default = ["sg-0dd2ac51aab7b4ab2"]
}

variable "key-name" {
  default = "my-multi-tier-key"

}
