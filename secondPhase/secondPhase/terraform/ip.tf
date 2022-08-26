resource "local_file" "machine_address" {
    content  = aws_instance.vm_tf_ac_xtr.public_ip
    filename = "../ansible/machineIp"
}