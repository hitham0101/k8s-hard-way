data "aws_ami" "Ubuntu_ami" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

}


resource "aws_instance" "master_node" {



  ami                         = data.aws_ami.Ubuntu_ami.id
  instance_type               = var.aws.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.aws.publicip
  key_name                    = var.key_name
  user_data = templatefile("${path.module}/scripts/master_node.tftpl",
    {
      key_pub = var.key_pub
  })

  vpc_security_group_ids = [
    var.sg_id
  ]

  root_block_device {
    delete_on_termination = true
    volume_size           = 14
    volume_type           = "gp2"
  }
  tags = {
    name = "master_node"
    OS   = "UBUNTU"
  }


}



resource "aws_instance" "worker_node" {

  count = var.workers_count

  ami                         = data.aws_ami.Ubuntu_ami.id
  instance_type               = var.aws.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.aws.publicip
  key_name                    = var.key_name
  user_data = templatefile("${path.module}/scripts/worker_node.tftpl",
    {
      key_pub = var.key_pub
  })

  vpc_security_group_ids = [
    var.sg_id
  ]

  root_block_device {
    delete_on_termination = true
    volume_size           = 14
    volume_type           = "gp2"
  }
  tags = {
    name = "worker-${count.index + 1}"
    OS   = "UBUNTU"
  }


}


resource "aws_instance" "jumpbox" {

  depends_on = [aws_instance.master_node, aws_instance.worker_node]
  # depends_on = [aws_instance.master_node]

  ami                         = data.aws_ami.Ubuntu_ami.id
  instance_type               = var.aws.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.aws.publicip
  key_name                    = var.key_name
  user_data = templatefile("${path.module}/scripts/jumpbox.tftpl",
    {
      key_pub            = var.key_pub,
      key_priv           = var.key_priv,
      master_private_ip  = aws_instance.master_node.private_ip,
      worker0_private_ip = aws_instance.worker_node[0].private_ip,
      worker1_private_ip = aws_instance.worker_node[1].private_ip,
  })

  vpc_security_group_ids = [
    var.sg_id
  ]

  root_block_device {
    delete_on_termination = true
    volume_size           = 14
    volume_type           = "gp2"
  }
  tags = {
    name        = "jumpbox"
    Environment = "DEV"
    OS          = "UBUNTU"
  }

  lifecycle {
    ignore_changes = [
      user_data
    ]
  }

}
