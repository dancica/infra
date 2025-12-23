data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "app1" {
  instance_type = var.instance_type
  ami           = data.aws_ami.ubuntu.id

  tags = merge(
    {
      "ManagedBy" = "Terraform"
    },
    var.instance_tags
  )
}
