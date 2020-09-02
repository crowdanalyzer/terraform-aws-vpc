output "public_ip" {
    value = aws_instance.instance.public_ip
    description = "The public IP address assigned to the bastion host instance created by this module."
}
