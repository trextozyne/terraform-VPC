output "instance" {
  value = aws_instance.myapp-server
}

output "aws_ami_latest" {
  value = data.aws_ami.latest-amazon-linux-image
}