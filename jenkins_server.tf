# configured aws provider with proper credentials
provider "aws" {
  region  = var.aws_region
  profile = var.profile
}


# launch the jenkins instance using ami : you can change this ami id with your own ami. 
resource "aws_instance" "jenkins_ec2_instance" {
  ami                    = var.jenkins_ami
  instance_type          = var.aws_instance_type
  vpc_security_group_ids = [aws_security_group.jenkins_security_gp.id]
 

  key_name               = aws_key_pair.instance_key.key_name

  tags = {
    Name  = "jenkins-server"
    Owner = "Hermann90"
  }
}



# an empty resource block
resource "null_resource" "name" {
  # ssh into the ec2 instance 
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(local_file.ssh_key.filename)
    hosts        = [aws_instance.jenkins_ec2_instance.public_ip, aws_instance.nexus_ec2_instance.public_ip, aws_instance.qa_server.public_ip, aws_instance.prod_server.public_ip]
  }
  # wait for ec2 to be created
  depends_on = [aws_instance.jenkins_ec2_instance, aws_instance.nexus_ec2_instance, aws_instance.prod_server, aws_instance.qa_server]
}

