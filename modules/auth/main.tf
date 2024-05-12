
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_file" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/../../.local/keys/${var.PROJECT_ID}-key"
}

resource "local_file" "public_key_file" {
  content  = tls_private_key.ssh_key.public_key_openssh
  filename = "${path.module}/../../.local/keys/${var.PROJECT_ID}-key.pub"
}
resource "aws_key_pair" "aws_key_pair" {
  key_name   = "${var.PROJECT_ID}-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}