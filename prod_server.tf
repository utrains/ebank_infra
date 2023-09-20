

#Server for production
resource "aws_instance" "prod_server" {
  count = var.prod_server ? 1 : 0
  ami   = var.prod_ami
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.qa_and_prod_security_gp.id]
  key_name = aws_key_pair.instance_key.key_name

   tags = {
    Name = "prod-server"
    Owner = "Hermann90"
  }
  # other instance configuration here
}