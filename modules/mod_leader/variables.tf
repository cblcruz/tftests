variable "security_group_id" {}
variable "user_data" {}
variable "EC2_ROOT_VOLUME_SIZE" {}
variable "EC2_ROOT_VOLUME_TYPE" {}
variable "EC2_ROOT_VOLUME_DELETE_ON_TERMINATION" {}
variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "user_data_file_path" {
  type = string
}

variable "name_tag" {
  type    = string
  default = "CC_TF_LD"
}

variable "ansible_group_tag" {
  type    = string
  default = "leader"
}

variable "ansible_index_tag" {
  type    = number
  default = 1
}
variable "key_name" {
  type = string
}

variable "public_key" {
  type = string
}

variable "private_key" {
  type = string
}

variable "authorized_keys" {
  type = string
}

variable "parent_private_key" {
  type = string
}
variable "parent_key_name" {
  type    = string
  default = "cribl_key"
}

variable "parent_authorized_keys" {
  type = string
}

variable "parent_public_key" {
  type = string
}