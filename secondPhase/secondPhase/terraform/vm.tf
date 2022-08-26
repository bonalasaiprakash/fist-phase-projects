resource "aws_instance" "vm_tf_ac_xtr" {
  depends_on = [
    aws_key_pair.dummy_xtr,
    aws_instance.vm_tf_ts_xtr
  ]
  ami           = "ami-04505e74c0741db8d" #ami           = "ami-0e472ba40eb589f49"
  instance_type = "t2.xlarge"
  key_name = aws_key_pair.dummy_xtr.key_name
  subnet_id = "subnet-0395c2d8d58252e76"
  ebs_block_device {
    delete_on_termination = true
    device_name = "/dev/sda1"
    volume_size  = 300
  }
  associate_public_ip_address  = true
  security_groups = [aws_security_group.sg_tf_ac_xtr.id]
  # user_data = <<-EOF
  #   #!/bin/bash
  #   sudo apt update
  #   sudo apt install ansible -y
  # EOF

  tags = {
    Name = "vm-tf-ac-xtr"
  }

  connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("../ssh/xtr")
      #host = aws_instance.vm_tf_ac_xtr.public_ip
      host = self.public_ip
  }

  provisioner "file" {
    source      = "../ssh/xtr"
    destination = "/tmp/xtr"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt upgrade",
      "sudo apt update",
      "sudo apt install ansible -y",
      "sudo chmod 666 /etc/ansible/hosts",
      "sudo echo '${aws_instance.vm_tf_ts_xtr.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/etc/ansible/xtr ansible_python_interpreter=/usr/bin/python3.8 ansible_ssh_extra_args=\"-o StrictHostKeyChecking=no\"' >> /etc/ansible/hosts",
      "sudo cp /tmp/xtr /etc/ansible/xtr"
    ]
  }
}

resource "aws_instance" "vm_tf_ts_xtr" {
  depends_on = [
    aws_key_pair.dummy_xtr
  ]
  ami           = "ami-04505e74c0741db8d" #ami           = "ami-0e472ba40eb589f49"
  instance_type = "t2.xlarge"
  key_name = aws_key_pair.dummy_xtr.key_name
  subnet_id = "subnet-0395c2d8d58252e76"
  ebs_block_device {
    delete_on_termination = true
    device_name = "/dev/sda1"
    volume_size  = 300
  }
  associate_public_ip_address  = true
  security_groups = [aws_security_group.sg_tf_ts_xtr.id]

  tags = {
    Name = "vm-tf-ts-xtr"
  }
}
