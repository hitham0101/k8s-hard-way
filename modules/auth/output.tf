# Keys
output "ssh-public-key" {
  value     = tls_private_key.ssh_key.public_key_openssh
  sensitive = true
}
output "ssh-private-key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

output "key_name" {
  value     = aws_key_pair.aws_key_pair.key_name
  sensitive = true
}
