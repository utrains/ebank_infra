# launch the Nexus instance using ami
resource "aws_instance" "nexus_ec2_instance" {
  count = var.nexus_server ? 1 : 0
  ami                    = var.nexus_ami
  instance_type          = var.aws_instance_type
  vpc_security_group_ids = [aws_security_group.nexus_security_gp.id]
  key_name               = aws_key_pair.instance_key.key_name

  /*user_data = <<-EOF
    #!/bin/bash
    /home/ec2-user/nexus/bin/nexus start
  EOF*/

  tags = {
    Name = "nexus-server"
    Owner = "Hermann90"
  }
  
}