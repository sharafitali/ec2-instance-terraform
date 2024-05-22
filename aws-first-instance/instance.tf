data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # AWS Canonical account ID for Ubuntu AMIs

  filter {
    name   = "name"
    values = ["${var.image_name}"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

}







#....creating the instance ......
resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]

  tags = {
    Name = "first-tf-instance"
  }
  user_data = file("${path.module}/userdata-script.sh")

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/id_rsa")
    host        = self.public_ip
  }




  # Provisioning files
  provisioner "file" {
    content     = "This is my content"
    destination = "/tmp/content.md"
  }

  provisioner "file" {
    source      = "Readme.md"
    destination = "/tmp/Readme.md"
  }




  # Provisioning local-exec 
  provisioner "local-exec" {
    working_dir = "/tmp"
    command     = "echo '${self.public_ip}' > mypublicip.txt"

  }

  provisioner "local-exec" {
    command = "echo 'at create' "

  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'at dlete'"

  }


  # Provisioning local-exec 
  provisioner "remote-exec" {
    inline = [
      "ifconfig > /tmp/ifconfig.output",
      "echo 'hello sharafit'>/tmp/test.txt"
    ]

  }
  provisioner "remote-exec" {
    script = "./testscript.sh"

  }
}



