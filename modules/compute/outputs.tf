output "jumpbox_public_ip" {
  value = aws_instance.jumpbox.public_ip

}

output "jumpbox_private_ip" {
  value = aws_instance.jumpbox.private_ip

}

output "master_node_public_ip" {
  value = aws_instance.master_node.public_ip

}

output "master_node_private_ip" {
  value = aws_instance.master_node.private_ip

}

output "worker_node0_public_ip" {
  value = aws_instance.worker_node[0].public_ip

}

output "worker_node0_private_ip" {
  value = aws_instance.worker_node[0].private_ip

}

output "worker_node1_public_ip" {
  value = aws_instance.worker_node[1].public_ip

}

output "worker_node1_private_ip" {
  value = aws_instance.worker_node[1].private_ip

}