resource "aws_instance" "jenkins" {
  ami           = "ami-03fd334507439f4d1"  
  instance_type = var.ec2_type       
  vpc_security_group_ids = [aws_security_group.eks_sg.id]
  subnet_id   = aws_subnet.first_subnet.id
  key_name = "ssh_key"


  associate_public_ip_address = true

   root_block_device {
    volume_size = 50  # Set the desired size in GiB (e.g., 50 GiB)
    volume_type = "gp3"  # Choose the volume type (e.g., gp2, gp3, io1)
  }

  tags = {
    Name = "jenkins"
  }
  
}