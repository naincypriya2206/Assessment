resource "aws_instance" "s1" {
  ami                         = "ami-07761f3ae34c4478d"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.web-sg.id]
  subnet_id                   = aws_subnet.public-subnet1.id
  associate_public_ip_address = true
  user_data                   = file("data1.sh")

  tags = {
    Name = "server1"
  }
}

resource "aws_instance" "s2" {
  ami                         = "ami-07761f3ae34c4478d"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.web-sg.id]
  subnet_id                   = aws_subnet.public-subnet1.id
  associate_public_ip_address = true
  user_data                   = file("data1.sh")

  tags = {
    Name = "server2"
  }
}