variable "public_cidr" {}
variable "private_cidr" {
    type = list(string)
}

variable "public_name" {}
variable "private_name" {}

variable "vpc_id" {}
