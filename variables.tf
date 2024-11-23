variable "vpc_id" {
  type = string
}

variable "private_subnets_id" {
  type = list(string)
}

variable "public_subnets_id" {
  type = list(string)
}

variable "linux-ami" {
  type = string
}

variable "webserver-ami" {
  type = string
}