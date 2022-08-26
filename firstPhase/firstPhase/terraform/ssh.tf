resource "aws_key_pair" "xtr" {
  key_name   = "xtr"
  public_key = file("../ssh/xtr.pub")
}