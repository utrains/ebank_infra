resource "aws_security_group" "rds" {
  name   = "ebanking_rds"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ebanking_rds"
  }
}

 # create default vpc if one does not exit
 resource "aws_default_vpc" "default_vpc" {
 }


# create security group for the Jenkins instance
resource "aws_security_group" "jenkins_security_gp" {
  name        = "jenkins sg"
  description = "allow access on ports 8080 and 22 for jenkins and ssh"
  vpc_id      = aws_default_vpc.default_vpc.id
  # allow access on port 8080 for Jenkins Server
  ingress {
    description = "httpd access port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # allow access on port 22 ssh connection
  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "jenkins sg"
  }
}



# create security group for the nexus instance
resource "aws_security_group" "nexus_security_gp" {
  name        = "nexus security group"
  description = "allow access on ports 8081 and 22 for nexus and ssh"
  vpc_id      = aws_default_vpc.default_vpc.id
  # allow access on port 8081 for nexus Server
  ingress {
    description      = "httpd access port"
    from_port        = 8081
    to_port          = 8081
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  # allow access on port 22 ssh connection
  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags   = {
    Name = "nexus security group"
  }
}

# Security group for QA and Prod Deployment
resource "aws_security_group" "qa_and_prod_security_gp" {
  name        = "qa-uat security group"
  description = "allow access on ports 8082 and 22 for nexus and ssh"
  vpc_id      = aws_default_vpc.default_vpc.id
  # allow access on port 8082 for application Server
  ingress {
    description      = "httpd access port"
    from_port        = 8082
    to_port          = 8082
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  # allow access on port 22 ssh connection
  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags   = {
    Name = "nexus security group"
  }
}