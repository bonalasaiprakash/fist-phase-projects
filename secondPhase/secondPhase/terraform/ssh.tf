resource "aws_key_pair" "dummy_xtr" {
  key_name   = "dummy-xtr"
  public_key = file("../ssh/xtr.pub")
}