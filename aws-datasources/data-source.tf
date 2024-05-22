data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # AWS Canonical account ID for Ubuntu AMIs

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
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


output "ami_id" {
  value = data.aws_ami.ubuntu.id
}