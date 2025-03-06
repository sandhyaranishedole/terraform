resource "aws_instance" "dev" {
    ami =var.ami_id
    instance_type = var.type
    key_name = var.key
  
}