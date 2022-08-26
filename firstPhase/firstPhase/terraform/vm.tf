resource "aws_instance" "vm_tf_jenkins_xtr" {
  depends_on = [
    aws_key_pair.xtr,
    aws_security_group.sg_tf_jenkins_xtr
  ]
  ami           = "ami-04505e74c0741db8d" #ami           = "ami-0e472ba40eb589f49"
  instance_type = "t2.xlarge"
  key_name = aws_key_pair.xtr.key_name
  subnet_id = "subnet-0395c2d8d58252e76"
  ebs_block_device {
    delete_on_termination = true
    device_name = "/dev/sda1"
    volume_size  = 300
  }
  associate_public_ip_address  = true
  security_groups = [aws_security_group.sg_tf_jenkins_xtr.id]

  tags = {
    Name = "vm-tf-jenkins-xtr"
  }

  connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("../ssh/xtr")
      #host = aws_instance.vm_tf_ac_xtr.public_ip
      host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt upgrade -y",
      "sudo apt update -y",
      "sudo apt install openjdk-8-jdk -y",
      "wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt upgrade -y",
      "sudo apt update -y",
      "sudo apt install jenkins -y"
      # "systemctl status jenkins"
    ]
  }
}
