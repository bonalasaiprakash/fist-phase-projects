resource "aws_security_group" "sg_tf_ac_xtr" {
  name        = "secgroup-tf-ac-tf-xtr"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0a60ecb242ee1073a"

  ingress {
    description      = "SSH from Internet"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  # ingress {
  #   description      = "http from Internet"
  #   from_port        = 8080
  #   to_port          = 8080
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]
  #   # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  # }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg-tf-ac-xtr"
  }
}


resource "aws_security_group" "sg_tf_ts_xtr" {
  name        = "secgroup-tf-ts-xtr"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0a60ecb242ee1073a"

  ingress {
    description      = "SSH from Internet"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description      = "http from Internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description      = "tomcat webserver from Internet"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg-tf-ts-xtr"
  }
}