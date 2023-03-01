data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
resource "aws_key_pair" "cribl_key" {
  key_name   = var.parent_key_name
  public_key = var.parent_public_key

}

resource "local_file" "linuxkey" {
  filename        = "linuxkey.pem"
  file_permission = "400"
  content         = var.private_key
}

resource "local_file" "cribl_key" {
  filename        = "authorized_keys"
  file_permission = "600"
  content         = var.authorized_keys
}

resource "aws_instance" "leader" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  security_groups = [var.security_group_id]
  key_name        = aws_key_pair.cribl_key.key_name
  user_data       = file(var.user_data_file_path)

  tags = {
    Name          = var.name_tag
    ansible-group = var.ansible_group_tag
    ansible-index = var.ansible_index_tag
  }

  provisioner "remote-exec" {
    inline = [
      "echo '${var.authorized_keys}' >> /home/ubuntu/.ssh/authorized_keys",
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.private_key
      host        = aws_instance.leader.public_ip
    }
  }
  root_block_device {
    volume_size           = var.EC2_ROOT_VOLUME_SIZE
    volume_type           = var.EC2_ROOT_VOLUME_TYPE
    delete_on_termination = var.EC2_ROOT_VOLUME_DELETE_ON_TERMINATION
  }
}