resource "aws_instance" "qa_server" {
  count = var.qa_server ? 1 : 0
  ami   = var.qa_ami
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.qa_and_prod_security_gp.id]
  key_name = aws_key_pair.instance_key.key_name

  tags = {
    Name = "qa-server"
    Owner = "Hermann90"
  }
  # other instance configuration here
}