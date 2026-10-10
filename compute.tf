data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "this" {
  ami                         = data.aws_ssm_parameter.al2023_ami.value
  instance_type               = "t3.micro"
  subnet_id                   = data.terraform_remote_state.base_infra.outputs.public_subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.base_infra.outputs.security_group_id]
  associate_public_ip_address = true


  tags = {
    Name      = "${var.project_id}-ec2"
    Terraform = "true"
    Project   = var.project_id
  }
}